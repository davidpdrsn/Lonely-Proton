class Tag < ActiveRecord::Base
  has_and_belongs_to_many :posts

  validates :name, presence: true
  validates :name, uniqueness: true

  def to_param
    [id, name.parameterize].join("-")
  end

  def ==(another_tag)
    if another_tag.is_a? TagWithDomId
      another_tag == self
    else
      super(another_tag)
    end
  end
end
