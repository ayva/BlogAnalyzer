require "mechanize"
require "grammarly.rb"
require "twitter_api"

class MediumScraper

  # Need to grab social media


  include GrammarCheck
  # include TwitterAPI

  attr_reader :post_urls

  # The "Top Stories" url for Medium
  TOP_STORIES_URL = "https://medium.com/top-stories"

  def initialize
    # Initialize mechanize agent
    @agent = Mechanize.new

    # Initialize empty array to hold post URLs
  end

  # Scrapes top stories to find blogs to add to database.
  # Returns a list of urls related to the top stories.
  def get_top_stories
    # Go to the top stories page, find the posts.
    page = @agent.get(TOP_STORIES_URL)
    posts = page.search("article")

    # Map the posts to their href urls.
    post_urls = posts[0].xpath("//article/a").map {|post| post.attributes["href"].value}

    # Return only non-nil urls.
    post_urls.compact
  end

  # Scrapes the stories of the top authors.
  def scrape_top_story_authors
    urls = get_top_stories

    # For each top story, get the list of author urls.
    author_urls = urls.map{|url| get_author(url)}.compact

    # Then, for each author url, go to the author's latest posts page and scrape the posts.
    author_urls[0..1].each do |author_url|
      scrape_author(author_url)
    end
  end

  def get_author(url)
    page = @agent.get(url)
    result = page.search('//*[@id="prerendered"]/article/header/div/div[1]/div/div[2]/a')[0]
    return result ? result.attributes["href"].text + "/latest" : nil
  end

  # Old scraper
  #
  # def scrape_blogs
  #   @post_urls.each do |url|
  #     page = @agent.get(url)
  #     author_post_urls = []
  #     unless page.search('//*[@id="prerendered"]/article/header/div/div[1]/div/div[2]/a')[0].nil?
  #       author_url = page.search('//*[@id="prerendered"]/article/header/div/div[1]/div/div[2]/a')[0].attributes["href"].text
  #       author_page = @agent.get(author_url + "/latest")
  #       posts = author_page.search("article")
  #       posts[0].xpath("//article/a").each do |post|
  #         author_post_urls << post.attributes["href"].value
  #       end
  #       author_post_urls.each_with_index do |au, i|
  #         break if i > 9
  #         begin
  #           scrape_blog(au, author_url)
  #         rescue
  #           Rails.logger.warn "URL failed"
  #         end
  #       end
  #     end
  #   end
  # end

  # Scrapes the latest 10 blog posts from the corresponding author url.
  def scrape_author(author_url)
    p "Scraping posts by #{author_url}"

    # Add check that author has not already been scraped in the past month

    author_page = @agent.get(author_url)
    posts = author_page.search("article")
    author_post_urls = posts[0].xpath("//article/a").map do |post|
      post.attributes["href"].value
    end

    author_post_urls[0..9].each_with_index do |au, i|
      begin
        scrape_blog(au, author_url)
      rescue
        Rails.logger.warn "URL failed"
      end
    end
  end

  # Scrapes 1 blog post
  def scrape_blog(url, author_url)
    sleep 1
    page = @agent.get(url)

    title = page.search('//*[@id="71bc"]').text
    body = page.search("div[@class='section-content']").search("p")

    content = parse_content(body)

    # Get author in scrape_author rather than
    # getting the author's page and scraping the information over and over
    author = scrape_author_info(author_url)

    word_count = content.split.size

    unless Post.where(post_url: url).length > 0
      post = Post.find_or_create_by(post_url: url,
                                    author_id: author.id,
                                    word_count: word_count)
      errors = check_errors(content)

      errors.each do |error|
        group = Group.find_or_create_by(name: error["group"])
        hint = Hint.find_or_create_by(title: error["title"],
                                      group_id: group.id)
        Posthint.find_or_create_by(post_id: post.id,
                                   hint_id: hint.id)
      end

    end

    author.score = author.overall_error_rate
    author.save

  end

  def parse_content(content)
    content.map{|p| p.text}.join(" ")
  end

  def scrape_author_info(author_url)
    page = @agent.get(author_url)

    url = author_url
    name = page.search('//*[@id="prerendered"]/div[2]/div/header/h1').text
    username = add_username(name)
    img = page.search('//*[@id="prerendered"]/div[2]/div/header/div[1]/div[2]/img')[0].attributes["src"].text
    twtr = get_twitter(page)
    fcbk = get_facebook(page)
    new_author = Author.find_or_create_by(full_name: name,
                                          username: username,
                                          blog_url: url,
                                          twitter: twtr,
                                          facebook: fcbk,
                                          author_pic: img)
  end

  # Wrapper methods for get_social_media
  def get_twitter(page)
    get_social_media('Twitter', page)
  end

  def get_facebook(page)
    get_social_media('Facebook', page)
  end

  # This looks like a prime place to use a maybe monad.
  # Returns the social media url or nil if not available.
  def get_social_media(type, page)
    media = page.search("a[@title='#{type}']")
    if media && media[0] && media[0].attributes["href"]
      return media[0].attributes["href"].text[2..-1]
    else
      return nil
    end
  end

  def add_username(name)
    name.downcase.gsub(" ", "")
  end


end
