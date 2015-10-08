
class SessionsController < ApplicationController


  def other
      # Exchange our oauth_token and oauth_token secret for the AccessToken instance.
      access_token = prepare_access_token(ENV['TW_OAuth_CONSUMER_KEY'], ENV['TW_OAuth_CONSUMER_SECRET'])
       
      # use the access token as an agent to get the home timeline
      response = access_token.request(:get, "https://api.twitter.com/1.1/statuses/home_timeline.json")

      # render text: response
        #request.env['omniauth.auth'] contains the Authentication Hash with all the data about a user.
        # render text: request.env['omniauth.auth'].to_yaml
  end

  def create
    if request.env["omniauth.auth"].present?

      oauth = User.new(request.env["omniauth.auth"], current_user)
      oauth.login_or_create
      session[:user_id] = oauth.user.id
      redirect_to root_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

  def prepare_access_token(oauth_token, oauth_token_secret)
    consumer = OAuth::Consumer.new("APIKey", "APISecret", { :site => "https://api.twitter.com", :scheme => :header })
     
    # now create the access token object from passed values
    token_hash = { :oauth_token => oauth_token, :oauth_token_secret => oauth_token_secret }
    access_token = OAuth::AccessToken.from_hash(consumer, token_hash )
 
    return access_token
  end


end
