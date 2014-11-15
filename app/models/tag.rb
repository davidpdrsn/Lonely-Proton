# == Schema Information
#
# Table name: tags
#
#  id   :integer          not null, primary key
#  name :string(255)
#

# Tag model
class Tag < ActiveRecord::Base
  has_and_belongs_to_many :posts, -> { where.not published_at: nil }

  validates :name, presence: true
  validates :name, uniqueness: true

  scope :find_for_ids, -> (ids) { where(id: ids) }

  def to_param
    [id, name.parameterize].join("-")
  end

  def ==(other)
    # TODO: Remove DIP violation
    if other.is_a? TagWithDomId
      other == self
    else
      super(other)
    end
  end
end
