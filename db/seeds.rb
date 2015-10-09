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

author1 = Author.create({author_pic: 'https://cdn-images-1.medium.com/fit/c/120/120/1*3R6E3UiBHI5YPPZ2YPA4bg.jpeg',
                        blog_url: 'https://medium.com/@annaharari',
                        full_name: 'Anna Harari',
                        username: 'annaharari',
                        score: 1.9}
                        )

author2 = Author.create({author_pic: 'https://cdn-images-1.medium.com/fit/c/120/120/0*B04L2Ma1UbOvo7xg.jpeg',
                        blog_url: 'https://medium.com/@gavinsblog',
                        full_name: 'Gavin Sheridan',
                        username: 'gavinsheridan',
                        score: 2.9}
                        )
author3 = Author.create({ author_pic: 'https://cdn-images-1.medium.com/fit/c/120/120/1*Cy0LBwZNc0Xjffyqv_37lA.png',
                        full_name: 'Aaron Bleyaert',
                        score: 5.3,
                        blog_url: "https://medium.com/@AaronBleyaert",
                        username: 'AaronBleyaert' })

author4 = Author.create({author_pic: 'https://cdn-images-1.medium.com/fit/c/120/120/1*XuKabEs8iEuneJxjJJ5JXw.jpeg',
                        full_name: 'Sloane Crosley',
                        score: 8.7,
                        blog_url: "https://medium.com/@askanyone",
                        username: 'askanyone' 

        })

leader1 = Leader.create({author_id: author1.id, 
                        score: 9.9 ,
                        category: 'Grammar'
        })

leader2 = Leader.create({author_id: author2.id,
                        score: 1.5,
                        category: 'Punctuation'
        })

leader3 = Leader.create({author_id: author3.id,
                        score: 8.8,
                        category: 'Style'
        })

leader4 = Leader.create({author_id: author4.id,
                        score: 6.3,
                        category: 'Structure'
        })



