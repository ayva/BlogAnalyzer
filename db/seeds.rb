# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Author.destroy_all
Leader.destroy_all
Post.destroy_all
Delayed::Job.destroy_all
Group.destroy_all
Hint.destroy_all
Posthint.destroy_all

MediumScraper.delay.scrape_top_story_authors
Author.delay.find_leaders
