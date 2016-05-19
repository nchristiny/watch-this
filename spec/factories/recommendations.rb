require 'securerandom'

FactoryGirl.define do
  factory :recommendation do
    winning_title { Faker::Book.title }
    winning_id    { SecureRandom.urlsafe_base64(24) }
    genres_pref   { Faker::Hipster.word }
    rating_pref   { Faker::Number.between(1, 10) }
    director_pref { Faker::Book.author }
    decade_pref   { ["70s", "90s", "2000 onwards"] }
    keywords_pref { Faker::Hipster.sentence }
    stars_pref    { Faker::StarWars.character }
  end
end
