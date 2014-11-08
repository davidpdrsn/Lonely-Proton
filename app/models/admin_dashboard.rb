class AdminDashboard
  def initialize(published:, drafts:)
    @published = published
    @drafts = drafts
  end

  attr_reader :published, :drafts
end
