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

# Need to make fake leaders after scraping top authors.

# leader1 = Leader.create({author_id: author1.id,
#                         score: 9.9 ,
#                         category: 'Grammar'
#         })

# leader2 = Leader.create({author_id: author2.id,
#                         score: 1.5,
#                         category: 'Punctuation'
#         })

# leader3 = Leader.create({author_id: author3.id,
#                         score: 8.8,
#                         category: 'Style'
#         })

# leader4 = Leader.create({author_id: author4.id,
#                         score: 6.3,
#                         category: 'Structure'
#         })
