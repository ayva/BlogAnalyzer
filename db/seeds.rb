# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Author.destroy_all
Post.destroy_all

author1 = Author.create({author_pic: 'https://cdn-images-1.medium.com/fit/c/120/120/1*3R6E3UiBHI5YPPZ2YPA4bg.jpeg',
                        blog_url: 'https://medium.com/@annaharari',
                        full_name: 'Anna Harari',
                        username: 'annaharari',
                        score: 91.9}
                        )

author2 = Author.create({author_pic: 'https://cdn-images-1.medium.com/fit/c/120/120/0*B04L2Ma1UbOvo7xg.jpeg',
                        blog_url: 'https://medium.com/@gavinsblog',
                        full_name: 'Gavin Sheridan',
                        username: 'gavinsheridan',
                        score: 92.9}
                        )







