FactoryGirl.define do
  factory :film do
    score         { Faker::Number.between(1, 1000) }
    title         { Faker::Book.title }
    genre         { Faker::Hipster.words }
    rating        { Faker::Number.between(1, 11) }
    summary       { Faker::Hacker.say_something_smart }
    poster_url    { Faker::Placeholdit.image }
    url           { Faker::Internet.url }
    director      { Faker::Book.author }
    year          { Faker::Number.between(1950, 2015) }
    stars         { Faker::Hipster.words(4) }
    keywords      { Faker::Hipster.sentences }
  end
end
