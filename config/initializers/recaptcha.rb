Recaptcha.configure do |config|
  config.site_key = Rails.application.credentials.dig(:recaptcha_v2, :production_site_key)
  config.secret_key = Rails.application.credentials.dig(:recaptcha_v2, :production_secret_key)
end