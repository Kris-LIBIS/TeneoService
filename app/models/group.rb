# frozen_string_literal: true

class Group < ApplicationRecord
  belongs_to :parent, class_name: 'Group', inverse_of: :children, optional: true
  has_many :children, class_name: 'Group', inverse_of: :group, dependent: :destroy

  has_many :users, through: :roles

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
        item.parent = parent_group if parent_group
        puts "Could not find parent group '#{parent}'" unless parent_group
      end
    end
  end

end
