require_relative "../../lib/decorated_collection"

describe DecoratedCollection do
  it "decorates a collection with a decorator" do
    objects = DecoratedCollection.new([double, double], DecoratorA)

    objects.each do |object|
      expect(object.added_method).to eq "foo"
    end
  end

  it "delegates present? to the collection" do
    collection = double("collection")
    probe = double
    allow(collection).to receive(:present?).and_return(probe)
    objects = DecoratedCollection.new(collection, double)

    expect(objects.present?).to eq probe
  end
end

class DecoratorA < SimpleDelegator
  def added_method
    "foo"
  end
end
