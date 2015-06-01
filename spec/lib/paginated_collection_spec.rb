require "rails_helper"

describe PaginatedCollection do
  it "enumerates the objs in pages" do
    objs = (1..100).to_a
    collection = PaginatedCollection.new(objs, page: 1, per_page: 10)

    page = collection.reduce([]) do |acc, n|
      acc << n
      acc
    end

    expect(page.size).to eq 10
    page.each { |n| expect(n).to be <= 10 }
  end

  it "enumerates the objs in the second page" do
    objs = (1..100).to_a
    collection = PaginatedCollection.new(objs, page: 2, per_page: 10)

    page = collection.reduce([]) do |acc, n|
      acc << n
      acc
    end

    expect(page.size).to eq 10
    page.each { |n| expect((11..20)).to include(n) }
  end

  describe "#next_page" do
    it "returns the next page" do
      collection = PaginatedCollection.new([], page: 1, per_page: 10)

      expect(collection.next_page).to eq 2
    end
  end

  describe "#next_page?" do
    it "returns true if there are more pages" do
      collection = PaginatedCollection.new([1,2,3], page: 1, per_page: 2)

      expect(collection.next_page?).to be_truthy
    end

    it "returns false if there are no more pages" do
      collection = PaginatedCollection.new([1,2,3], page: 2, per_page: 2)

      expect(collection.next_page?).to be_falsy
    end
  end

  describe "#present?" do
    it "returns true if there objects in the page" do
      collection = PaginatedCollection.new([1,2,3], page: 2, per_page: 2)

      expect(collection).to be_present
    end

    it "returns false if there objects in the page" do
      collection = PaginatedCollection.new([], page: 2, per_page: 2)

      expect(collection).not_to be_present
    end
  end
end
