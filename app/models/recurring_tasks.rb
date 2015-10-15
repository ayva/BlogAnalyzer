class RecurringTask
  include Delayed::RecurringJob

  run_every 1.day
  run_at '9:01am'
  timezone 'US/Pacific'

  def perform
    MediumScraper.scrape_top_story_authors
    Author.find_leaders
  end
end
