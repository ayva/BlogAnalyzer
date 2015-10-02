require "mechanize"

class MediumScraper

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

  end

  def scrape_blogs
    @post_urls.each do |url|
      scrape_blog(url)
    end
  end

  def scrape_blog(url)
    page = @agent.get(url)

    title = page.search('//*[@id="71bc"]').text
    body = page.search('//*[@id="prerendered"]/article/main/section/div[2]/div[1]')

    content = parse_content(body)
    author_url = page.search('//*[@id="prerendered"]/article/header/div/div[1]/div/div[2]/a')[0].attributes["href"].text


  end

  def parse_content(content)
    parsed_content = []
    content[0].children.each do |p|
      parsed_content << p.text
    end
    parsed_content
  end

  def scrape_author_info(author_url)
    page = agent.get(author_url)

    url = author_url
    name = page.search('//*[@id="prerendered"]/div[2]/div/header/h1').text
    img = page.search('//*[@id="prerendered"]/div[2]/div/header/div[1]/div[2]/img')[0].attributes["src"].text
    new_author = Author.find_or_create_by(name: name,
                                          blog_url: url,
                                          author_pic: img)
  end


  end
end