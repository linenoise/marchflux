
$LOAD_PATH.push('.')

require 'mongoid'
require 'rubygems'
require 'tweetstream'
require 'json'
require 'colored'
require 'yaml'
require 'twitter'

ENV['RACK_ENV'] ||= 'development'

Mongoid.load!("./mongoid.yml")

Dir['./models/*.rb'].each do |model|
	require model
end
