class LandingPagesController < ApplicationController
  require 'grammarly'
  require 'medium_scraper'
  include GrammarCheck



  def test
    text = "Spotify has tripled in size (company size & users) during just those two years, and I had the opportunity to work on a range of interesting projects. From helping to establish our product design guidelines to evolving our brand identity, it’s been a blast. While some projects launched, others are of course still confidential and have yet to find it’s way to the world."

   @data = check_errors(text)

     # MediumScraper.scrape_author("https://medium.com/@triketora")
     # author = Author.find(39)
     #  MediumScraper.scrape_post("https://medium.com/@jaycarney/jay-carney-s-response-to-dean-baquet-c0407042e893?source=latest---------1", author)
     # @data = author.posts
    # @data = Author.last.score
    # Author.find_leaders

  end

  def main

  end


end
