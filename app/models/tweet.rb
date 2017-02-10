
require 'geocoder'
class Tweet
  include Mongoid::Document
  include Geocoder::Model::Mongoid

  def self.save_tweet(tweet)
    twt = Tweet.new(message: tweet.text, hashtags: tweet.hashtags.map{|x| x[:text]}, address: tweet.user.location, tweeted_at: tweet.created_at)
    twt.save!
  end

  field :message, type: String
  field :hashtags, type: Array
  field :coordinates, :type => Array
  field :address
  field :tweeted_at, type: DateTime

  geocoded_by :address               # can also be an IP address
  after_validation :geocode          # auto-fetch coordinates

  # rake db:mongoid:create_indexes
end
