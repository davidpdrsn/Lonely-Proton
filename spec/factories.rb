FactoryGirl.define do
  factory :post do |f|
    sequence(:title) { |n| "Learning iOS #{n}" }
    markdown "its **fun** to learn ios, but also quite hard"
    published_at Time.now
    sequence(:slug) { |n| "Learning iOS #{n}".parameterize }
  end

  factory :tag do
    name "JavaScript"
  end
end
