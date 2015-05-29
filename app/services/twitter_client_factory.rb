class TwitterClientFactory
  def initialize(real:, fake:)
    @real = real
    @fake = fake
  end

  def new
    if Rails.env.production?
      real
    else
      fake
    end
  end

  private

  attr_reader :real, :fake
end
