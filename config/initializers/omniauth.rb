Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '913980685325-ibp09lbrkb4918lppji3qnotslfc9te0.apps.googleusercontent.com', 'WF_O0aGQWnWXE_aDvyMW6dlP'
end