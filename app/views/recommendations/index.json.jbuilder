json.array!(@recommendations) do |recommendation|
  json.extract! recommendation, :id, :score, :title, :genres_pref, :director_pref, :decade_pref, :keywords_pref, :stars_pref, :summary_pref
  json.url recommendation_url(recommendation, format: :json)
end
