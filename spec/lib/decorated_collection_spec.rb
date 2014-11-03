require 'rails_helper'

describe DecoratedCollection do
  it 'decorates a collection with a decorator' do
    objects = DecoratedCollection.new([double, double], DecoratorA)

    objects.each do |object|
      expect(object.added_method).to eq "foo"
    end
  end

  it 'delegates present? to the collection' do
    collection = double('collection')
    allow(collection).to receive(:present?).and_return(:foo)
    objects = DecoratedCollection.new(collection, double)

    expect(objects.present?).to eq :foo
  end
end

class DecoratorA < SimpleDelegator
  def added_method
    "foo"
  end
end
