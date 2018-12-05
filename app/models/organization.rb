# frozen_string_literal: true

class Organization < ApplicationRecord
  belongs_to :parent, class_name: 'Organization', inverse_of: :children, optional: true
  has_many :children, class_name: 'Organization', inverse_of: :organization, dependent: :destroy

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
        parent_organization = Organization.find_by(name: parent)
        item.parent = parent_organization if parent_organization
        puts "Could not find parent organization '#{parent}'" unless parent_organization
      end
    end
  end

end
