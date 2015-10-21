class LandingPagesController < ApplicationController
  
  require 'medium_scraper'
  include GrammarCheck



  def test
    text = "Spotify has tripled in size (company size & users) during just those two years, and I had the opportunity to work on a range of interesting projects. From helping to establish our product design guidelines to evolving our brand identity, it’s been a blast. While some projects launched, others are of course still confidential and have yet to find it’s way to the world."

    @data = GrammarCheck::check_errors(text)



  end

  def main

  end


end
