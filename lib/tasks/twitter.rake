require 'eventmachine'
require 'fiber'
  desc 'pulls feed'
  task twitter_stream: :environment do |t, args|
    # clears tweet database
      EM.run do
        # twitter creds
        client = Twitter::Streaming::Client.new do |config|
          # MOVE INTO ENV VARIABLES
          config.consumer_key        = "fN1FWoIo4Q3WmWYPHuqCyA"
          config.consumer_secret     = "IJ71PJzH5Qwol2QEhMHoMpnGuh0l5IfpiokWIzOI"
          config.access_token        = "30624088-rUXFJVlA5hHb3aDnAsdhCy8sQYtkNmvoECQukh0Y"
          config.access_token_secret = "ev5YKmTWXfuLv46fub04fPO0lC6hewR4nxMrSmwLw0"
        end
          fibers = [Fiber.current]
          client.filter(:locations => "-180,-90,180,90") do |tweet|
            fibers << Fiber.new do
              puts tweet.message
              # Tweet.save_tweet(tweet)
            end
          end
        EM.stop
      end
  end
