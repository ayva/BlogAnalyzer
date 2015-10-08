
class TwitterAPI

  attr_reader :baseurl, :consumer_key, :access_token
  

  def initialize  
    @baseurl = "https://api.twitter.com"

    @consumer_key = OAuth::Consumer.new(
        Rails.application.secrets.TW_CONSUMER_KEY,
        Rails.application.secrets.TW_CONSUMER_SECRET)
    @access_token = OAuth::Token.new(
        Rails.application.secrets.TW_ACCESS_TOKEN,
        Rails.application.secrets.TW_ACCESS_SECRET)
  end

  #Check if response status 200 with given Auth keys
  def verify 
    # The verify credentials endpoint returns a 200 status if
    # the request is signed correctly.
    address = URI("#{@baseurl}/1.1/account/verify_credentials.json")

    # Set up Net::HTTP to use SSL, which is required by Twitter.
    http = Net::HTTP.new address.host, address.port
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER

    # Build the request and authorize it with OAuth.
    request = Net::HTTP::Get.new address.request_uri
    request.oauth! http, @consumer_key, @access_token

    # Issue the request and return the response.
    http.start
    response = http.request request
    return "The response status was #{response.code}"
  end

  #!!!This is actually twitting to GrandMa timeline!!!

  def follow(name)
        #To make Grandma to follow name account
    path    = "/1.1/friendships/create.json"
    address = URI("#{@baseurl}#{path}?screen_name=#{name}")
    request = Net::HTTP::Post.new address.request_uri
    request.set_form_data(
      "follow" => true,
    )
    send_request(request,address)
  end

  def  twit(name)

    text = "Grandma just checked @#{name}\'s grammar on Medium, see results here #{linkToBloggerReview}!"
       #To post in GrandMa's timeline
    path    = "/1.1/statuses/update.json"
    address = URI("#{@baseurl}#{path}")
    request = Net::HTTP::Post.new address.request_uri
    request.set_form_data(
      "status" => text,
    )
    send_request(request,address)
  end

  def send_message(text, name)

    text = text || "Grandma just checked @#{name} grammar!"

    #To post in follower's timeline
    path    = "/1.1/direct_messages/new.json"
    address = URI("#{@baseurl}#{path}?screen_name=#{name}")
    request = Net::HTTP::Post.new address.request_uri
    request.set_form_data(
      "text" => text,
    )
    send_request(request,address)
  end

  def send_request(request, address)

        # Set up HTTP.
    http             = Net::HTTP.new address.host, address.port
    http.use_ssl     = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER

    # Issue the request.
    request.oauth! http, @consumer_key, @access_token
    http.start
    response = http.request request

    # Parse and print the Tweet if the response code was 200
    tweet = nil
    if response.code == '200' then
      tweet = JSON.parse(response.body)
      puts "Successfully sent #{tweet["text"]}"
    else
      puts "Could not send the Tweet! " +
      "Code:#{response.code} Body:#{response.body}"
    end

  end

    # Parse a response from the API and return a user object.
  def parse_user_response(response)

    user = nil

    # Check for a successful request
    if response.code == '200'
      # Parse the response body, which is in JSON format.
      # ADD CODE TO PARSE THE RESPONSE BODY HERE
      user = JSON.parse(response.body)

      # Pretty-print the user object to see what data is available.
      puts "Hello, #{user["screen_name"]}!"
    else
      # There was an error issuing the request.
      puts "Expected a response of 200 but got #{response.code} instead"
    end

    user
  end

  def get_user

    address = URI("#{@baseurl}/1.1/account/verify_credentials.json")

    http             = Net::HTTP.new address.host, address.port
    http.use_ssl     = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    
      # Issue the request.
    request = Net::HTTP::Get.new address.request_uri
    request.oauth! http, consumer_key, access_token
    http.start
    response = http.request(request)
    return parse_user_response(response)

  end




end

