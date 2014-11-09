# == Schema Information
#
# Table name: tags
#
#  id   :integer          not null, primary key
#  name :string(255)
#

class Tag < ActiveRecord::Base
  has_and_belongs_to_many :posts, -> { where.not published_at: nil }

  validates :name, presence: true
  validates :name, uniqueness: true

  scope :find_for_ids, -> (ids) { where(id: ids) }

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
