# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Tweet.create(message: 'Hello', location: {:lat => 44.1077, :lng => -23}, hashtags: ['werwre', 'dfdfd'], tweeted_at: DateTime.now)
Tweet.create(message: 'There', location: {:lat => 47.13667, :lng => -53}, hashtags: ['ywro', 'dfdrewfd'], tweeted_at: DateTime.now)
Tweet.create(message: 'World', location: {:lat => 24.1047, :lng => -83.935833}, hashtags: ['yorwe', 'helrwrlo'], tweeted_at: DateTime.now)
Tweet.create(message: 'Hi!!', location: {:lat => 10.1767, :lng => -33}, hashtags: ['yorwr', 'helrwrlo'], tweeted_at: DateTime.now)
