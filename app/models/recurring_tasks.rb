class RecurringTask
  include Delayed::RecurringJob

  run_every 1.day
  run_at '10:45pm'
  timezone 'US/Pacific'

  def perform
    MediumScraper.scrape_top_story_authors
    Author.find_leaders
  end
end


# RecurringTask.schedule!