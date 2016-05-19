require 'nokogiri'
require 'json'
require 'open-uri'
require 'anemone'

# To get a more complete list of URLs to titles
def crawl(link,like_pattern,skip_pattern)
  new_file = File.open("url_list.txt", "w")
  Anemone.crawl(link) do |anemone|
    p "Scraping in progress..."
    anemone.skip_links_like(skip_pattern)
    anemone.on_pages_like(like_pattern) do |page|
      p "Hey this matches our pattern: #{page.url}"
      new_file.write("#{page.url}\n")
    end
    anemone.on_every_page do |page|
      timer = 1 + rand(2)
      p "#{page.url}, Sleeping for #{timer} seconds"
      sleep timer
    end
  end
  new_file.close
end


crawl("http://www.imdb.com/title/",/tt\d+\//,/\?.*|.*\/trivia\/.*|.*\/news\/.*|.*\/jobs.*|.*\/imdbjobs.*|.*\/offsite.*|.*\/help.*|.*\/conditions.*|.*\/privacy.*|.*\/news\/.*|.*\/reviews.*|.*\/name\/.*/)
