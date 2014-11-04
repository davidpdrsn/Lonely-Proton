class Post < ActiveRecord::Base
  has_and_belongs_to_many :tags

  validates :markdown, presence: true
  validates :title, presence: true

  before_save :parse_and_save_markdown

  def self.sorted
    order('created_at DESC')
  end

  def to_param
    [id, title.parameterize].join("-")
  end

  private

  def parse_and_save_markdown
    self.html = MarkdownParser.new.parse(markdown)
  end
end
