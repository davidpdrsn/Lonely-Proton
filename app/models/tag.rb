# == Schema Information
#
# Table name: tags
#
#  id   :integer          not null, primary key
#  name :string(255)
#

class Tag < ActiveRecord::Base
  has_and_belongs_to_many :posts, lambda {
    where.not(published_at: nil)
      .recently_published_first
  }

  validates :name, presence: true
  validates :name, uniqueness: true

  scope :find_for_ids, -> (ids) { where(id: ids) }

  def self.tags_with_posts
    all.select(&:posts?)
  end

  def to_param
    [id, name.parameterize].join("-")
  end

  def ==(other)
    if other.is_a? TagWithDomId
      other == self
    else
      super(other)
    end
  end

  def posts?
    posts.count > 0
  end
end
