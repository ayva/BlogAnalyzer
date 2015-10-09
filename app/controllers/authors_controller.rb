class AuthorsController < ApplicationController

  def totals
    total = Author.count
    totalarticles = Post.count
    totalissues = Posthint.count

    respond_to do |format|
      format.json { render json: [total, totalarticles, totalissues] }
    end
  end


  def leaderboards
    featuredauthors = Author.last(10)
    grandmatop = Author.all.order("score asc").limit(10)
    
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

    respond_to do |format|

      #!!!! Include data for personal page so that I can call it like blogger.totalposts / errors etc + hint
      format.json { render json: @author.to_json(
        include: [:posts, hints: {include: :group}]
                          
        ) 
      }
    end
  end

end

