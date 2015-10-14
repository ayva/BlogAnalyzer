require 'medium_scraper.rb'
require 'rufus-scheduler'

scheduler = Rufus::Scheduler.new

scheduler.every("1d") do
  MediumScraper.get_top_authors
  Author.delay.find_leaders
end
