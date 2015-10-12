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
    @post_urls = []
  end

  def get_stories
    ## Scrapes top stories to find blogs to add to database ##
    page = @agent.get(TOP_STORIES_URL)

    # Get posts
    posts = page.search("article")

    posts[0].xpath("//article/a").each do |post|
      @post_urls << post.attributes["href"].value
    end

    scrape_blogs

  end

  def scrape_blogs
    @post_urls.each do |url|
      # Extract to own method
      page = @agent.get(url)
      author_post_urls = []
      unless page.search('//*[@id="prerendered"]/article/header/div/div[1]/div/div[2]/a')[0].nil?
        author_url = page.search('//*[@id="prerendered"]/article/header/div/div[1]/div/div[2]/a')[0].attributes["href"].text
        author_page = @agent.get(author_url + "/latest")
        posts = author_page.search("article")
        posts[0].xpath("//article/a").each do |post|
          author_post_urls << post.attributes["href"].value
        end
        author_post_urls.each_with_index do |au, i|
          break if i > 9
          begin
            scrape_blog(au)
          rescue
            Rails.logger.warn "URL failed"
          end
        end
      end
    end
  end

  # !!!Scrapes one post, not an entire blog!!!
  def scrape_blog(url)
      page = @agent.get(url)

      title = page.search('//*[@id="71bc"]').text
      body = page.search("div[@class='section-content']").search("p")

      content = parse_content(body)
      author_url = page.search('//*[@id="prerendered"]/article/header/div/div[1]/div/div[2]/a')[0].attributes["href"].text
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
    parsed_content = []
    content.each do |p|
      p p.text
      parsed_content << p.text
    end
    parsed_content.join(" ")
  end

  def scrape_author_info(author_url)
    page = @agent.get(author_url)

    url = author_url
    name = page.search('//*[@id="prerendered"]/div[2]/div/header/h1').text
    username = add_username(name)
    img = page.search('//*[@id="prerendered"]/div[2]/div/header/div[1]/div[2]/img')[0].attributes["src"].text
    twtr = page.search("a[@title='Twitter']")[0].attributes["href"]
    fcbk = page.search("a[@title='Facebook']")[0].attributes["href"]
    new_author = Author.find_or_create_by(full_name: name,
                                          username: username,
                                          blog_url: url,
                                          twitter: twtr,
                                          facebook: fcbk,
                                          author_pic: img)
  end

  def add_username(name)
    name.downcase.gsub(" ", "")
  end


end