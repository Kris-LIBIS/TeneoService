# frozen_string_literal: true

class Organization < ApplicationRecord
  belongs_to :parent, class_name: 'Organization', inverse_of: :children, optional: true
  has_many :children, class_name: 'Organization', inverse_of: :organization, dependent: :destroy

  belongs_to :producer
  belongs_to :material_flow

  has_many :memberships, dependent: :destroy
  has_many :roles, through: :memberships
  has_many :users, through: :memberships

  accepts_nested_attributes_for :memberships, allow_destroy: true

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
      if (producer_name = h.delete(:producer))
        producer = Producer.find_by(name: producer_name)
        item.producer = producer if producer
        puts "Could not find producer '#{producer_name}'" unless producer
      end
      if (material_flow_name = h.delete(:material_flow))
        material_flow = MaterialFlow.find_by(name: material_flow_name)
        item.material_flow = material_flow if material_flow
        puts "Could not find material flow '#{material_flow_name}'" unless material_flow
      end
    end
  end

end
