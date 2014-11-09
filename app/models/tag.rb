class Tag < ActiveRecord::Base
  has_and_belongs_to_many :posts, -> { where.not published_at: nil }

  validates :name, presence: true
  validates :name, uniqueness: true

  def self.find_for_ids(ids)
    where(id: ids)
  end

  def to_param
    [id, name.parameterize].join("-")
  end

  def ==(another_tag)
    # TODO: Remove DIP violation
    if another_tag.is_a? TagWithDomId
      another_tag == self
    else
      super(another_tag)
    end
  end
end
