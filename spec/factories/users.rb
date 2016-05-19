FactoryGirl.define do
  factory :user do
    name "Heironymous Bosch"
    email { Faker::Internet.email }
    password "12345678"
    password_confirmation "12345678"
    auth_token "cQvrNoOolecbJ2JH8nYjPw"
  end
end
