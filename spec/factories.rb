FactoryGirl.define do
  factory :post do
    sequence(:title) { |n| "Learning iOS #{n}" }
    markdown 'its **fun** to learn ios, but also quite hard'
    draft false
  end

  factory :tag do
    name 'JavaScript'
  end
end
