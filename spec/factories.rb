FactoryGirl.define do
  factory :post do
    title 'Learning iOS'
    markdown 'its **fun** to learn ios, but also quite hard'
  end

  factory :tag do
    name 'JavaScript'
  end
end
