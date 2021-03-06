require 'geocoder'
class Tweet
  include Mongoid::Document
  include Mongoid::Geospatial
  include Geocoder::Model::Mongoid

  def self.save_tweet(tweet)
    twt = new(message: tweet.text)
    twt.hashtags = tweet.hashtags.map{|x| x[:text].downcase}
    twt.address = tweet.user.location
    twt.tweeted_at = tweet.created_at
    twt.save!
  end

  field :message, type: String
  field :hashtags, type: Array
  field :coordinates, :type => Point, sphere: true
  field :address
  field :tweeted_at, type: DateTime

  geocoded_by :address               # can also be an IP address
  after_validation :geocode          # auto-fetch coordinates

  index({ coordinates: '2dsphere', hashtags: 1 }, { background: true })
  # rake db:mongoid:create_indexes
end
