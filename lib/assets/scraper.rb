# Scraping targets for database info
require 'json'
require 'nokogiri'
require 'open-uri'

raw_title_array = File.readlines("lib/assets/url_list_dirty.txt").each {|line| line.chomp!}
title_url_array = raw_title_array.uniq
p "Formed array of #{title_url_array.count} unique URLs"
counter = 0

title_url_array.each do |title_url|
  doc = Nokogiri::HTML(open(title_url))
  p "**********************************************************"
  p "Working on film ##{counter + 1}"
  film_properties = {}

  # Title with (Year)
  doc.css('h1').each do |link|
    film_properties[:title] = link.content.strip
  end

  # Genre
  genre = []
  doc.css('#titleStoryLine .inline+ a').each do |link|
    genre << link.children.first.content.strip
    film_properties[:genre] = genre
  end

  # Rating
  doc.css('strong span').each do |link|
    film_properties[:rating] = link.content.to_f
  end

  # Summary
  doc.css('.summary_text').each do |link|
    film_properties[:summary] = link.content.strip
  end

  # Poster image URL
  unless doc.at_css('#title-overview-widget img').nil?
    film_properties[:poster_url] = doc.at_css('#title-overview-widget img').attr('src')
  else
    film_properties[:poster_url] = "Poster unavailable"
  end

  film_properties[:url] = title_url

  # Director
  doc.css('.summary_text+ .credit_summary_item .itemprop').each do |link|
    film_properties[:director] = link.children.first.content.strip
  end

  # Stars
  stars = []
  doc.css('.credit_summary_item~ .credit_summary_item+ .credit_summary_item .itemprop').each do |link|
    stars << link.children.first.content.strip
    film_properties[:stars] = stars
  end

  # Keywords
  #titleStoryLine .itemprop
  keywords = []
  doc.css('#titleStoryLine .itemprop').each do |link|
    keywords << link.children.first.content.strip
    film_properties[:keywords] = keywords
  end

  p "Adding #{film_properties[:title]} to database"
  p film_properties
  Film.find_or_create_by(film_properties)
  timer = 1 + rand(1)
  p "Success! Random delay of #{timer} seconds before next one... ZZZzzz"
  sleep timer
  counter += 1
  films = Film.all
  p "There are #{films.count} films in the database presently."
end
