module GrammarCheck

  def check_errors(text)
    api_url = Rails.application.secrets.grammarly_API_url

    headers = {"Connect-Type" => "text/plain",
                "Accept" => "application/json"}

    response = HTTParty.post(api_url, :body => text, :headers =>headers)

    data = response.parsed_response

    puts data
  end
end