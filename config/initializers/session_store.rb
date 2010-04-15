# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_JXI-DBManager_session',
  :secret      => '025fc46efc53ab472b4d0cd511dc10912839e21aeb43dcb74f610549042712353d345adae5c8c58652fbcfec3078e1f80c22874a10c96c4d019c8d8ae9f18b3a'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
