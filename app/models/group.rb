class Group < ApplicationRecord
  belongs_to :parent, class_name: 'Group', inverse_of: :children, optional: true
  has_many :children, class_name: 'Group', inverse_of: :parent, dependent: :destroy

  serialize :upload_areas, HashSerializer

  def ancestors
    result = [self]
    while (g = result.last.parent)
      result << g
    end
  end

end
