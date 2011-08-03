#!/usr/bin/env ruby

require 'rubygems'
require 'tweetstream'
require 'twitter'
require 'json'

# Track tweets
def startListening
 
  # Enter your details if you want to tweet back
  Twitter.configure do |config|
    config.consumer_key = "[your app key]"
    config.consumer_secret = "[your app secret]"
    config.oauth_token = "[your oauth token]"
    config.oauth_token_secret = "[your oauth secret]"
  end
  
  # Initialize your Twitter client
  @client = Twitter::Client.new

  puts "Listening for tweets.."
  # Use 'follow' to follow a group of user ids (integers, not screen names)
  TweetStream::Client.new("[username]", "[password]").track("[search query]") do |status|
      message = talk(status.user.screen_name)
      @client.update(message)
    end      
  end
end

def talk(name)
  "@#{name}, hi"
end

begin
  startListening()
rescue Interrupt => error
  puts "Quiting.."
  exit
rescue => error
  #raise error
  puts "Something went wrong: #{error.inspect}"
  puts "Retrying in 5 seconds.."
  sleep 5
  retry
end
