class Group < ApplicationRecord
  belongs_to :group, inverse_of: :children, optional: true
  has_many :children, class_name: 'Group', inverse_of: :group, dependent: :destroy

  serialize :upload_areas, HashSerializer

  def ancestors
    result = [self]
    while (g = result.last.parent)
      result << g
    end
  end

  def self.from_hash(hash)
    super(hash) do |item, h|
      if (parent = h.delete(:parent))
        parent_group = Group.find_by(name: parent)
        return item.group = parent_group if parent_group
        puts "Could not find parent group '#{parent}'"
      end
    end
  end

end
