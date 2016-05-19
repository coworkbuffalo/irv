require 'rubygems'
require 'bundler'
require 'open-uri'

Bundler.require

desc "Scrape sue's special"
task :sues do
  url = "http://www.suesnydeli.com/?_escaped_fragment_=daily-specials/ccf6"
  doc = Nokogiri::HTML(open(url))
  food = doc.css('#comp-ifnu3xbq').text.split("\n").select { |line| line =~ /\A\w/ }.join("\n")

  def match(food, pattern)
    food.match(pattern)[1].gsub("\n", " ")
  end

  client = Twitter::REST::Client.new do |config|
    config.consumer_key        = ENV["CONSUMER_KEY"]
    config.consumer_secret     = ENV["CONSUMER_SECRET"]
    config.access_token        = ENV["ACCESS_TOKEN"]
    config.access_token_secret = ENV["ACCESS_SECRET"]
  end

  salads  = match(food, /(Salads.*)Soups/m)
  soups   = match(food, /(Soups.*)Special/m)
  special = match(food, /(Special.*)$/m)

  [salads, soups, special].each do |item|
    client.update item

    RestClient.post ENV['SLACK_URL'], {
      text: item
    }.to_json, content_type: :json, accept: :json
  end
end
