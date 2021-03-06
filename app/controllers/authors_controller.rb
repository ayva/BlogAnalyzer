require 'authors_helper'
require 'json'
require 'open-uri'

class AuthorsController < ApplicationController
  include AuthorsHelper

  def totals
    total = Author.count
    totalarticles = Post.count
    totalissues = Posthint.count

    respond_to do |format|
      format.json { render json: [total, totalarticles, totalissues] }
    end
  end



  def leaderboards
    featuredauthors = Author.where('score < 50').last(10)
    grandmatop = Author.joins(:posts).group('authors.id').having('sum(posts.word_count) > 3000 ').order("score asc").limit(10)

    respond_to do |format|
      format.json { render json: [featuredauthors,grandmatop] }
    end
  end


  def grouptop
    leaders = Leader.all

    respond_to do |format|
      format.json { render json: leaders.to_json(include: :author)  }
    end
  end


  def index
    @authors = Author.all

    respond_to do |format|

      # Renders the usual `index.html.erb` template
      format.html

      # Send back a specific collection, so no template
      #   needed
      format.json { render json: @authors }
    end
  end


  def show
    @author = Author.find(params[:id])
    @hintstable = hintstable(params[:id])
    @rating =    ( Author.where("score <= ?", @author.score).count.to_f / Author.count * 100).round(0)


  end

  def newblogger
    respond_to do |format|
      # validate url
      @author =  Author.find_by_blog_url(params[:url])
      if(@author)
        format.json { render json: "This blog was checked already. Follow the link <a href='#/blogger/#{@author.username}?id=#{@author.id}'>#{@author.full_name}</a>".to_json }
      else
        begin
          open(params[:url])
        rescue
          format.json { render json: "The blog could not be found. Please try again." }
        else
          
          MediumScraper.delayed_scrape_author(params[:url])
          format.json { render json: "<h5><a href='https://twitter.com/GrandmaCheck' class='twitter-follow-button' data-show-count='false'>Follow @GrandmaCheck</a> to know when your blog is ready.</h5>".to_json }
        end
      end
    end

  end

  private
  def params_list
    params.require(:author).permit(:url, :id)
  end
end

