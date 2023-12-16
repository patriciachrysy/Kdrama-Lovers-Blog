FactoryBot.define do
  factory :user do
    name { 'Test User' }
    posts_counter { 0 }
    photo { Faker::LoremFlickr.image } # Add this line
  end
end
