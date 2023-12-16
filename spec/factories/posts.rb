# spec/factories/posts.rb
FactoryBot.define do
  factory :post do
    sequence(:title) { |n| "Post Title #{n}" }
    text { 'Post text' }
    author { association(:user) }
    likes_counter { 0 }
    comments_counter { 0 }
  end
end
