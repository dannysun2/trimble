require 'eventmachine'
require 'fiber'
  desc 'pulls feed'
  task twitter_stream: :environment do |t, args|
    # clears tweet database
      EM.run do
        # twitter creds
        client = Twitter::Streaming::Client.new do |config|
          # MOVE INTO ENV VARIABLES
          config.consumer_key        = ENV['CONSUMER_KEY']
          config.consumer_secret     = ENV['CONSUMER_SECRET']
          config.access_token        = ENV['ACCESS_TOKEN']
          config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
        end
          client.filter(:locations => "-180,-90,180,90", :language => 'en', :filter_level => 'low') do |tweet|
            Fiber.new{
              Tweet.save_tweet(tweet)
            }.resume
          end
        EM.stop
      end
  end
