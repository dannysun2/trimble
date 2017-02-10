require 'eventmachine'
require 'fiber'
  desc 'pulls feed'
  # task testing_feed: :environment do
  task :testing_feed, [:obj] => :environment do |t, args|
    # clears tweet database
    # Tweet.delete_all
      EM.run do
        # twitter creds
        client = Twitter::Streaming::Client.new do |config|
          # MOVE INTO ENV VARIABLES
          config.consumer_key        = "fN1FWoIo4Q3WmWYPHuqCyA"
          config.consumer_secret     = "IJ71PJzH5Qwol2QEhMHoMpnGuh0l5IfpiokWIzOI"
          config.access_token        = "30624088-rUXFJVlA5hHb3aDnAsdhCy8sQYtkNmvoECQukh0Y"
          config.access_token_secret = "ev5YKmTWXfuLv46fub04fPO0lC6hewR4nxMrSmwLw0"
        end
        topics = ["hey"]
        # pulls requested hashtags and converts to array
          fibers = [Fiber.current]
          # search by hashtags, long, lat, and radius
          longitude = args.obj[:longitude].to_s
          latitude = args.obj[:latitude].to_s
          client.filter(:track => topics.join(','), :location => "#{longitude},#{latitude}") do |tweet|
            Tweet.save_tweet(tweet)
          end
        EM.stop
      end
  end
