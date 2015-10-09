require 'medium_scraper.rb'
require 'rufus-scheduler'

scheduler = Rufus::Scheduler.new

scheduler.every("1m") do
   scraper = MediumScraper.new
   scraper.get_stories
end