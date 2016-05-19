# Cleaning database info
films = Film.all
p "There are #{films.count} films in the database presently."

films.each do |film|
  new_film_properties = {}

  # Deleting all TV shows
  p "Selected item is #{film[:title]}"
  # \(\b\d{4}\b\) selects any four digits in parenthesis e.g. "(1997)"
  if film[:title].scan(/\(\b\d{4}\b\)/)[0].nil?
    p "Deleting this TV series"
    film.destroy
    next  # Move to the next document
  end

  # Delete all blank genres
  p "Checking the genre for #{film[:title]}"
  unless (film[:genre]).nil?
    p "Genre exists therefore doing nothing with #{film[:title]}"
  else
    p "Deleting #{film[:title]} due to blank genre"
    film.destroy
    next  # Move to the next document
  end

 # Delete all blank ratings
  p "Checking the ratings for #{film[:title]}"
  unless (film[:rating]).nil?
    p "Rating exists therefore doing nothing with #{film[:title]}"
  else
    p "Deleting #{film[:title]} due to blank rating"
    film.destroy
    next  # Move to the next document
  end

  p "Extracting year from #{film[:title]}"
  # Using \(\b\d{4}\b\) to capture only years in parenthesis, e.g. "2001: A Space Odyssey (1963)"
  year = film[:title].scan(/\(\b\d{4}\b\)/)[0]
  # Eliminate parenthesis and convert to integer: "(1963)" to 1963
  new_film_properties[:year] = year.scan(/\b\d{4}\b/)[0].to_i
  film.update_attributes(new_film_properties)
  p "Updated #{film[:title]} with Year: #{film[:year]}"
end
p "There are now #{films.count} actual films in the database."
