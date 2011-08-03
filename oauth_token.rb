#!/usr/bin/env ruby

require 'rubygems'
require 'oauth'

class String
  def get 
    print "#{self}"
    gets.strip
  end
end

begin
  consumer_key = 'Consumer Key: '.get
  consumer_secret = 'Consumer Secret: '.get

  consumer = OAuth::Consumer.new(
    consumer_key,
    consumer_secret,
    :site => 'http://api.twitter.com'
  )

  request_token = consumer.get_request_token

  system('open', request_token.authorize_url) || puts("Access here: #{request_token.authorize_url}\nand...")
  pin = 'PIN: '.get

  access_token = request_token.get_access_token(
    :oauth_token => request_token.token,
    :oauth_verifier => pin
  )

  puts "Token: " + access_token.token
  puts "Secret: " + access_token.secret
rescue
  puts "Error: #{$!}"
end
