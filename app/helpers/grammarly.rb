module GrammarCheck
  def check_errors(text)
      api_url = Rails.application.secrets.grammarly_API_url
      headers = {"Content-Type" => "text/plain",
                  "Accept" => "application/json"}
      result = HTTParty.post(api_url, :headers => headers, :body => text).parsed_response
      p '======================================================='
      p result
      return result
  end
end
