# Grandma

Check live project on [Grandma](http://grandma.space)

Grandma checks Medium bloggers grammar via Grammarly API and provides hints how to improve grammar.

Contributors:

* [Ayvazyan Olga](https://github.com/ayva)
* [Nick Sarlo](https://github.com/sicknarlo)
* [David Meza](https://github.com/david-meza)
* [Donald Kelsey](https://github.com/shadefinale)

### Geting Started
*  Clone and run `bundle install` to install the required gems
*  Run `rake db:migrate` and `rake db:seed` to get the database initialized
*  Optionally run `rspec` to make sure all tests are passing
*  Fire up your `rails server` and head to `localhost:3000` to check it out!

### Walkthrough

#### Database
The database is seeded with data from [Medium](https://medium.com/). The schema consists of several tables, namely authors (bloggers), leaders, posts, posthints (join table), hints, and groups (error categories). Most of this information is seeded to the database once on Rails using a rake task, and then displayed on the browser with Angular using Restangular API calls.

#### Testing
###### Controller Testing
Because the Rails part of the app is primarily an API to serve the front end, the controller tests check that you get the proper responses when making a request in a json format. It also checks that when making a post request to create an author, it checks if he or she already exists in the database and adds them to the delayed job queue if they do not.

###### Model Testing
Since Grandma checks focuses on finding grammar errors and providing hints to improve it, the model test is centered on the author or blogger. It checks things like that the author has a score related to him or her (in reality we don't generate an author unless there's an existing blog post they've written). We also test that error rates such as style and punctuation are working properly

#### Back-end
As briefly mentioned before, the back-end is used as an API to provide nearly instant results to a change in route. There are also several moving parts to prepare the data in the first place such as scraping top authors and posts from Medium.

#### Front-end
Our Front-end is built on AngularJS. We used Angular because the information we love the two-way data binding, and Angular provided us with access to that real-time updating feature. We used many interesting directives (e.g. animating counting to a number, autoplaying the video) and filters (e.g. capitalizing, splitting camel case) which you could check out on the source code.

Some libraries we are dependent on for the front-end are AngularJS, Angular Bootstrap, Angular ChartJS, Angular UI Router and Restangular. These could be easily installed by running `bower install`

#### Guided Tour
Step 1. Visit [Grandma](http://grandma.space)

Step 2. Go to leaderboards located on the navbar

Step 3. Click on the check my blog button and fill the input field with your medium profile URL (we'll take care of the rest!)

Step 4. That's it! Wait a minute or so and then check your name on the `find a blogger` input field on the navbar.

