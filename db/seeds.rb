require 'json'
require 'nokogiri'
require 'open-uri'

# # Backup current films to JSON file.
# films = Films.all
# films.each do |film|
#   film_json = JSON.parse(film.to_json)
#   File.open("db/data.json","a") do |f|
#     f.puts film_json.to_json
#   end
# end

film_array = File.readlines("db/data.json").each {|line| line.chomp!}

film_array.each do |e|
  film_json = JSON.parse(e)
  Film.find_or_create_by(film_json)
end
films = Film.all
p "There are #{films.count} films in the database presently."

# Default user
user = User.new({ name: "John Doe", email:"example@example.com", password:"12345678" })
user.save
user.auth_token

recc = Recommendation.new({ genres_pref: "Feel Good, Comedy, Noir-ish, Drama", director_pref: "Tommy Wiseau", decade_pref:["80s", "90s", "2000 onwards"], keywords_pref: "awesome and cool, Hi Doggie!", stars_pref: "Bruce Lee, Chuck Norris", rating_pref: 7.4 })
recc.save
recc.calculate!
Film.zero_score!

recc2 = Recommendation.find_or_create_by({ genres_pref:"Horror, Adventure, Comedy", director_pref:"Stanley Kubrick", decade_pref:["Pre 70s", "80s"], keywords_pref:"high octane thrill ride, noir, another random keyword", rating_pref: 4.1, stars_pref:"Al Pacino, Daffy Duck" })
recc2.calculate!
Film.zero_score!

# CLI commands to create recommendations
#
# $ curl -H 'Content-type: application/json' -X POST -d '{ "recommendation": { "genres_pref":"Adventure, Comedy,Action, War", "director_pref":"James Cameron", "decade_pref":["Any"], "keywords_pref":"high octane thrill ride, noir, explosion, future", "rating_pref": 6, "stars_pref":"Al Pacino, Daffy Duck, Mark Wahlberg"  } }' http://localhost:3000/api/recommendations

# $ curl -H 'Content-type: application/json' -X POST -d '{ "recommendation": { "genres_pref":"Action, Crime, Thriller", "director_pref":"James Wan", "decade_pref":["70s, 80s, 90s"], "keywords_pref":"high octane thrill ride, car falling off a cliff, revenge, star died before release", "rating_pref": 7, "stars_pref":"Vin Diesel, Paul Walker"  } }' http://localhost:3000/api/recommendations
#
