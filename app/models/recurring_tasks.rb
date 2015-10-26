class RecurringTask
  include Delayed::RecurringJob

  run_every 1.day
  run_at '8:35am'
  timezone 'US/Pacific'

  def perform
    MediumScraper.scrape_top_story_authors
    Author.find_leaders
  end
end


# RecurringTask.schedule!