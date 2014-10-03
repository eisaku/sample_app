# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
#SampleApp::Application.config.secret_key_base = 'c6a9cd2eb1bc5bbcf8c3ce2bdbaefe49d80b92f24bd5f7de62036eae18df2392d2f9201f900a1c729323cc98ad5367c8c55584433d55923e030fb3be8f4fc5d0'

require 'securerandom'

def secure_token
  token_file = Rails.root.join('.secret')
 
  if File.exist?(token_file)
    File.read(token_file).chomp
  else
    token = SecureRandom.hex(64)
    File.write(token_file, token)
    token
  end 
end

SampleApp::Application.config.secret_key_base = secure_token
