require 'eventmachine'
require 'fiber'
  desc 'pulls feed'
  task :testing_feed, [:long, :lat, :radius, :hashtags] => :environment do |t, args|
      EM.run do
        client = Twitter::Streaming::Client.new do |config|
          config.consumer_key        = "fN1FWoIo4Q3WmWYPHuqCyA"
          config.consumer_secret     = "IJ71PJzH5Qwol2QEhMHoMpnGuh0l5IfpiokWIzOI"
          config.access_token        = "30624088-rUXFJVlA5hHb3aDnAsdhCy8sQYtkNmvoECQukh0Y"
          config.access_token_secret = "ev5YKmTWXfuLv46fub04fPO0lC6hewR4nxMrSmwLw0"
        end
        topics = ["#love"]
          fibers = [Fiber.current]
          client.filter(:track => topics.join(','), :geocode => "40.7033127,-73.979681, 5000km") do |tweet|
            fibers << Fiber.new do
              puts tweet.text
            end
          end
        EM.stop
      end
  end
