module GrammarCheck
  def check_errors(text)
      api_url = Rails.application.secrets.grammarly_API_url
      token = Rails.application.secrets.grammarly_token
      headers = { "Content-Type" => "text/plain",
                  "Accept" => "application/json",
                  "Cookie" => "grauth=#{token}",
                  "Cache-Control" => "no-cache"
                  }
      result = HTTParty.post(api_url, :headers => headers, :body => text).parsed_response
      p '======================================================='
      p result
      return result
  end
end
