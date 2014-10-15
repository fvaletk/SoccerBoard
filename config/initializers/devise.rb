# Use this hook to configure devise mailer, warden hooks and so forth.
# Many of these configuration options can be set straight in your model.
Devise.setup do |config|

  config.secret_key = 'e985f0a6a3e6413c65ac7edbcca98be8a0ea3bba61bbc150a648cb7b782bcb37740498365b8e4bdecc5359a5282eea50362b3c922b6d14b9e30b177fb99d35c8'

  config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'


  require 'devise/orm/active_record'


  config.case_insensitive_keys = [ :email ]


  config.strip_whitespace_keys = [ :email ]

  config.skip_session_storage = [:http_auth]

  config.stretches = Rails.env.test? ? 1 : 10


  config.reconfirmable = true

  config.expire_all_remember_me_on_sign_out = true


  config.password_length = 8..128


  config.reset_password_within = 6.hours

  config.scoped_views = true

 
  config.sign_out_via = :delete


  config.omniauth :facebook, "348614958647124", "fac8096801a55c4afd4993eaeefadada"
  config.omniauth :twitter, "O1Busz5xlBwlnSpbjbCFQpxVj", "TRynmfRstNeIy5GlZr6PjvceojP9ju9QPbJhn8xxNwUjD2OzDZ"

end
