class Post < ActiveRecord::Base
  has_and_belongs_to_many :tags

  validates :markdown, presence: true
  validates :title, presence: true
  validates :title, uniqueness: true

  before_save :parse_and_save_markdown

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
    [id, title.parameterize].join("-")
  end

  def published?
    published_at?
  end

  def draft?
    !(published? || new_record?)
  end

  private

  def parse_and_save_markdown
    # TODO: Remove DIP violation
    self.html = MarkdownParser.new.parse(markdown)
  end
end
