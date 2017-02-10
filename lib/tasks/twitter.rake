require 'eventmachine'
require 'fiber'
  desc 'pulls feed'
  task testing_feed: :environment do
  # task :testing_feed, [:obj] => :environment do |t, args|
    # puts obj
    # clears tweet database
    # Tweet.delete_all
      EM.run do
        # twitter creds
        client = Twitter::Streaming::Client.new do |config|
          config.consumer_key        = "fN1FWoIo4Q3WmWYPHuqCyA"
          config.consumer_secret     = "IJ71PJzH5Qwol2QEhMHoMpnGuh0l5IfpiokWIzOI"
          config.access_token        = "30624088-rUXFJVlA5hHb3aDnAsdhCy8sQYtkNmvoECQukh0Y"
          config.access_token_secret = "ev5YKmTWXfuLv46fub04fPO0lC6hewR4nxMrSmwLw0"
        end
        topics = ["trump"]
        # pulls requested hashtags and converts to array
          fibers = [Fiber.current]
          # search by hashtags, long, lat, and radius
          client.filter(:track => topics.join(','), :location => "40.7033127,-73.979681") do |tweet|
            Tweet.save_tweet(tweet)
          end
        EM.stop
      end
  end
