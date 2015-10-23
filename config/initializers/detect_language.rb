DetectLanguage.configure do |config|
  config.api_key = Rails.application.secrets.LANGUAGE_KEY
end