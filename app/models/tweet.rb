class Tweet
  include Mongoid::Document
  include Mongoid::Geospatial

  field :message, type: String
  field :hashtags, type: Array
  field :location, type: Point
  field :tweeted_at, type: DateTime

  # Inserts Tweets into a MongoDB “tweets” collection that has a geo-spatial index to ensure fast query
  spatial_index :location
end
