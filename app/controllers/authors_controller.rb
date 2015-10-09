class AuthorsController < ApplicationController

  def totalbloggers
    total = Author.count
    respond_to do |format|
      format.json { render json: total }
    end
  end

  def mediumfeaturedbloggers
    # Change to right collection of bloggers
    featuredauthors = Author.all

    respond_to do |format|
      format.json { render json: featuredauthors }
    end
  end



  def grouptop
    leaders = Leader.all

    respond_to do |format|
      format.json { render json: leaders  }
    end
  end

  def grandmatop
     # Change to right collection of bloggers
    grandmatop = Author.all

    respond_to do |format|
      format.json { render json: grandmatop }
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

