# == Schema Information
#
# Table name: posts
#
#  id           :integer          not null, primary key
#  title        :string(255)
#  markdown     :text
#  created_at   :datetime
#  updated_at   :datetime
#  html         :text
#  link         :string(255)
#  published_at :datetime
#  slug         :string(255)
#

class Post < ActiveRecord::Base
  has_and_belongs_to_many :tags

  validates :title, :markdown, :slug, presence: true
  validates :title, :slug, uniqueness: true

  scope :recently_created_first, -> { order("created_at desc") }
  scope :drafts, -> { where(published_at: nil) }

  scope :recently_published_first, -> {
    where.not(published_at: nil).order("published_at desc")
  }

  scope :where_content_or_title_matches, -> (query_param) {
    where("(title || markdown) ILIKE ?", "%#{query_param}%")
      .recently_published_first
  }

  def to_param
    [id, slug.parameterize].join("-")
  end

  def published?
    published_at?
  end

  def draft?
    !(published? || new_record?)
  end
end
