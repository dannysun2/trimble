# namespace :twitter do
  desc 'pulls feed'
  task :testing_feed, [:long, :lat, :radius] => :environment do |t, args|
    puts args.long, args.lat, args.radius
    # client = Twitter::Streaming::Client.new do |config|
    #   config.consumer_key        = "fN1FWoIo4Q3WmWYPHuqCyA"
    #   config.consumer_secret     = "IJ71PJzH5Qwol2QEhMHoMpnGuh0l5IfpiokWIzOI"
    #   config.access_token        = "30624088-rUXFJVlA5hHb3aDnAsdhCy8sQYtkNmvoECQukh0Y"
    #   config.access_token_secret = "ev5YKmTWXfuLv46fub04fPO0lC6hewR4nxMrSmwLw0"
    # end
    #
    # topics = ["ruby", "python"]
    #   client.filter(track: topics.join(",")) do |tweet|
    #     puts tweet.text
    #   end
  end
# end
