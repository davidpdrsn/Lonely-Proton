# Facade for a list of published posts, and one of drafts
class AdminDashboard
  def initialize(published:, drafts:)
    @published = published
    @drafts = drafts
  end

  attr_reader :published, :drafts
end
