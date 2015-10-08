Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['TW_OAuth_CONSUMER_KEY'], ENV['TW_OAuth_CONSUMER_SECRET']
    
end


