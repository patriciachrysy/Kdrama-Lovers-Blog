FactoryBot.define do
  factory :comment do
    text { 'Comment text' }
    association :post
  end
end
