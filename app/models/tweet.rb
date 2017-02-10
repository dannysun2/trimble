
require 'geocoder'
class Tweet
  include Mongoid::Document
  include Mongoid::Geospatial
  include Geocoder::Model::Mongoid

  def self.save_tweet(tweet)
    twt = Tweet.new(message: tweet.text, hashtags: tweet.hashtags.map{|x| x[:text]}, address: tweet.user.location, tweeted_at: tweet.created_at)
    twt.save!
  end

  field :message, type: String
  field :hashtags, type: Array
  field :coordinates, :type => Point
  field :address
  field :tweeted_at, type: DateTime

  geocoded_by :address               # can also be an IP address
  after_validation :geocode          # auto-fetch coordinates

  spatial_index :coordinates
  # rake db:mongoid:create_indexes
end
