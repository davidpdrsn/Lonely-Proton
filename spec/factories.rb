FactoryGirl.define do
  factory :post do
    sequence(:title) { |n| "Learning iOS #{n}" }
    markdown 'its **fun** to learn ios, but also quite hard'
    published_at Time.now
  end

  factory :tag do
    name 'JavaScript'
  end
end
