#!/usr/bin/env ruby

require './app'

run Rack::URLMap.new( {
	"/" => Welcome,
  "/hashtags" => Hashtags,
  "/people" => People,
  "/channels" => Channels,
  "/tweets" => Tweets
})