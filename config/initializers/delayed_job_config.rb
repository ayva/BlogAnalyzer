require 'medium_scraper'
require 'recurring_tasks'

Delayed::Worker.destroy_failed_jobs = false
Delayed::Worker.logger = Logger.new(File.join(Rails.root, 'log', 'delayed_job.log'))

if caller.last =~ /script\/delayed_job/ or (File.basename($0) == "rake" and ARGV[0] =~ /jobs\:work/)
  ActiveRecord::Base.logger = Delayed::Worker.logger
end
puts "Scheduling job"
RecurringTask.schedule!