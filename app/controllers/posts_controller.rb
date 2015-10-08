class PostsController < ApplicationController

  def index

    @posts = Post.all

    respond_to do |format|

      # Renders the usual `index.html.erb` template
      format.html

      # Send back a specific collection, so no template
      #   needed
      format.json { render json: @posts }
    end
  end

  def show

    @post = Post.find(params[:id])

    respond_to do |format|

      # Renders the usual `index.html.erb` template
      format.html

      # Send back a specific collection, so no template
      #   needed
      format.json { render json: @post }
    end
  end

  def totalarticles
    totalarticles = Post.count
    
    respond_to do |format|
      format.json {render json: totalarticles}
    end
  end

  def totalissues
    totalissues = Posthint.count
    
    respond_to do |format|
      format.json {render json: totalissues}
    end
  end

end
