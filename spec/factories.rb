FactoryGirl.define do
  factory :post do
    sequence(:title) { |n| "Learning iOS #{n}" }
    markdown "its **fun** to learn ios, but also quite hard"
    html "its <strong>fun</strong> to learn ios, but also quite hard"
    published_at Time.now
    slug { title.parameterize }
  end

  factory :tag do
    name "JavaScript"
  end
end
