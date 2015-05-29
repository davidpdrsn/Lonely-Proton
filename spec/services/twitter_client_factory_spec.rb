require "rails_helper"

describe TwitterClientFactory do
  it "returns a fake twitter client in test environment" do
    fake = double("fake")
    real = double("real")

    client = TwitterClientFactory.new(
      real: real,
      fake: fake,
    ).new

    expect(client).to eq fake
  end

  it "returns a fake twitter client in production environment" do
    with_env("production") do
      fake = double("fake")
      real = double("real")

      client = TwitterClientFactory.new(
        real: real,
        fake: fake,
      ).new

      expect(client).to eq real
    end
  end

  def with_env(env)
    original_env = Rails.env
    Rails.env = env
    yield
    Rails.env = original_env
  end
end
