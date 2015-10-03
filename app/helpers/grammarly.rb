module GrammarCheck


  def check_errors(text)

      api_url = Rails.application.secrets.grammarly_API_url
      binding.pry
      headers = {"Content-Type" => "text/plain",
                  "Accept" => "application/json"}
      return HTTParty.post(api_url, :headers => headers, :body => text).parsed_response

  end
end