require 'medium_scraper.rb'
require 'rufus-scheduler'

scheduler = Rufus::Scheduler.new

scheduler.every("1d") do
   scraper = MediumScraper.new
   scraper.get_top_stories
end
