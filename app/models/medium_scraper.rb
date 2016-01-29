require "mechanize"


def agent
  Mechanize.new
end


class MediumScraper

  attr_reader :post_urls, :get_top_stories, :get_author

  # The "Top Stories" url for Medium
  TOP_STORIES_URL = "http://medium.com/top-stories"

  MEDIUM_REGEX = /(https:\/\/medium.com\/@[^\/]+)(?:\/?)/


  def self.check_errors(text)
    api_url = Rails.application.secrets.grammarly_API_url
    token = Rails.application.secrets.grammarly_token

    address = URI("#{api_url}")
    request = Net::HTTP::Post.new address.request_uri
    request.body = text
    request["Content-Type"]="text/plain"
    request["Accept"]="application/json"
    request["Cookie"]="grauth=#{token}"
    request["Cache-Control"]="no-cache"
    puts request
    # Set up HTTP.
    http             = Net::HTTP.new address.host, address.port
    http.read_timeout = 500
    http.use_ssl     = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER

    
    http.start
    return http.request(request).body

  end

  # Scrapes top stories to find blogs to add to database.
  # Returns a list of urls related to the top stories.
  def self.get_top_stories
    # Go to the top stories page, find the posts.
    page = agent.get(TOP_STORIES_URL)
    posts = page.search("article")

    # Map the posts to their href urls if titles are in english.
    post_urls = posts[0].xpath("//article/a/div/div/section/div/div/h3").reject{|post| 
      DetectLanguage.simple_detect(post.text) != "en"}.map {|post| 

        post.parent.parent.parent.parent.parent.parent.attributes["href"].value
 
    }
    puts "Found #{post_urls.compact.length} en articles in top stories"
    # Return only non-nil urls.
    post_urls.compact
    
  end

  # Scrapes the stories of the top authors.
  def self.scrape_top_story_authors
    urls = get_top_stories

    # For each top story, get the list of author urls.
    author_urls = urls.map{|url| get_author(url)}.compact

    # Then, for each author url, go to the author's latest posts page and scrape the posts.
    author_urls.each do |author_url|     
      #Checks if sanitized url is already scrapped
      scrape_author(author_url) if Author.find_by_blog_url(MediumScraper.sanitize_author_url(author_url)).nil?
    end
  end

  def self.get_author(url)
    page = agent.get(url)
    result = page.search('//*[@id="prerendered"]/article/header/div/div[1]/div/div[2]/a')[0]
    return result ? result.attributes["href"].text : nil
  end

  def self.delayed_scrape_author(author_url)
    MediumScraper.delay.scrape_author(author_url)
  end

  def self.sanitize_author_url(url)
    url = url.match(MEDIUM_REGEX) ? url.match(MEDIUM_REGEX)[0] : nil
    url = url[0..-2] if url && url[-1] == "/"
    url
  end

  # Scrapes the latest 10 blog posts from the corresponding author url.
  def self.scrape_author(author_url)
    p "Scraping posts by #{author_url}"

    author_url = MediumScraper.sanitize_author_url(author_url)

    # Author was checked if it exists in author controller

    author_page = agent.get(author_url + "/latest")
    author = MediumScraper.scrape_author_info(author_url)
    posts = author_page.search("article")

    author_post_urls = posts[0].xpath("//article/a/div/div/section/div/div/h3").reject{|post| DetectLanguage.simple_detect(post.text) != "en"}.map {|post| 
        
        post.parent.parent.parent.parent.parent.parent.attributes["href"].value
 
    }
    if author_post_urls.length == 0 
     
      author.destroy
      p "No English text found for author #{author.id}"
      return 
    end

    author_post_urls[0..9].each_with_index do |au, i|
      begin
        sleep 1
        p "Scraping #{au}"
        MediumScraper.scrape_post(au, author)
      rescue
        Rails.logger.warn "URL failed #{au}"
      end
    end
    author.score = author.overall_error_rate
    p "#{author.id} author id score is #{author.score}"
    if author.save
      if author.score.nil? || author.score.nan? || author.score == 100
        p "Author #{author.id} has to be destroyed because of score #{author.score}"
         Author.find(author.id).destroy
      else
        twtr = author.twitter
        if twtr
          p "Grandma will twit to #{twtr}"
          TwitterAPI.new.delay.tweet_twitter_user(twtr.split("/").last, author.id)
        else
          p "Grandma will twit with no twitter account"
          TwitterAPI.new.delay.tweet_non_twitter_user(author.full_name, author.id)
        end
      end
    end
  end


  # Scrapes 1 blog post
  def self.scrape_post(url, author)
    sleep 1
    page = agent.get(url)
    p "Agent got #{page}"
    title = page.search('.section-content/div/h3').first.text
    p "Title is #{title}"
    body = page.search("div[@class='section-content']").search("p")
    
    content = MediumScraper.parse_content(body)
    p "Content is #{content}"
    word_count = content.split.size
    p "URL #{url} has content size #{content.length} and #{word_count} words"

    post = Post.find_by_post_url(url)
    if post
      post.post_url = url
      post.author_id = author.id
      post.word_count = word_count
      post.save
      p "Post #{post.id} updated for #{author.id}"
    else
     
      post = Post.find_or_create_by(post_url: url,
                                    author_id: author.id,
                                    word_count: word_count)
      p "Post #{post.id} created for #{author.id}"
    end
      MediumScraper.update_hints(post, content)
  end



  def self.update_hints(post, content)
    # In case post already had hints we want only new one
    post.hints.destroy_all
    errors = JSON.parse(MediumScraper.check_errors(content))
    
    
    p "Checked errors for #{post.id}, found errors #{errors.length}"
    errors.each do |error|
        group = Group.find_or_create_by(name: error["group"])
        hint = Hint.find_or_create_by(title: error["title"],
                                      group_id: group.id)

        Posthint.create(post_id: post.id, hint_id: hint.id)
    end
  end

  def self.parse_content(content)
    p "Content parsed"
    content.map{|p| p.text}.join(" ")
  end

  def self.scrape_author_info(author_url)
    page = agent.get(author_url)

    url = author_url
    name=page.link_with(:href => url).text
    # name = page.search('//*[@id="prerendered"]/div[2]/div/header/h1').text.split(" ").map(&:capitalize).join(" ")
    username = MediumScraper.add_username(name)
    # img = page.search('//*[@id="prerendered"]/div[2]/div/header/div[1]/div[2]/img')[0].attributes["src"].text
    img = page.search('.avatar/img')[0].attributes["src"].text
    twtr = MediumScraper.get_twitter(page)
    fcbk = MediumScraper.get_facebook(page)

    author = Author.find_by_blog_url(url)
    if author
      return author
    else
      new_author = Author.find_or_create_by(full_name: name,
                                            username: username,
                                            blog_url: url,
                                            twitter: twtr,
                                            facebook: fcbk,
                                            author_pic: img)

      return new_author
    end
  end

  # Wrapper methods for get_social_media
  def self.get_twitter(page)
    get_social_media('Twitter', page)
  end

  def self.get_facebook(page)
    get_social_media('Facebook', page)
  end

  # This looks like a prime place to use a maybe monad.
  # Returns the social media url or nil if not available.
  def self.get_social_media(type, page)
    media = page.search("a[@title='#{type}']")
    if media && media[0] && media[0].attributes["href"]
      return media[0].attributes["href"].text[2..-1]
    else
      return nil
    end
  end

  def self.add_username(name)
    name.downcase.gsub(" ", "")
  end


end
