json.array!(@films) do |film|
  json.extract! film, :id, :title, :genre, :rating, :summary, :poster_url, :url, :director, :year, :stars
  json.url film_url(film, format: :json)
end
