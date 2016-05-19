require 'open-uri'
require 'nokogiri'

desc "Scrape sue's special"
task :sues do
  url = "http://www.suesnydeli.com/?_escaped_fragment_=daily-specials/ccf6"
  doc = Nokogiri::HTML(open(url))
  food = doc.css('#comp-ifnu3xbq').text.split("\n").select { |line| line =~ /\A\w/ }.join("\n")

  def match(food, pattern)
    food.match(pattern)[1].gsub("\n", " ")
  end

  puts match(food, /(Salads.*)Soups/m)
  puts match(food, /(Soups.*)Special/m)
  puts match(food, /(Special.*)$/m)
end
