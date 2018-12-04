# frozen_string_literal: true

class IngestModel < ApplicationRecord
  belongs_to :template, class_name: 'IngestModel', inverse_of: :implementations, optional: true
  has_many :implementations, class_name: 'IngestModel', inverse_of: :template, dependent: :destroy

  belongs_to :access_right, optional: false
  belongs_to :retention_policy, optional: false

  def self.from_hash(hash)
    super(hash) do |item, h|
      if (template_name = h.delete(:template))
        template = IngestModel.find_by(name: template_name)
        item.template = template if template
        puts "Could not find template '#{template_name}'" unless template
      end
      if (access_right_name = h.delete(:access_right))
        access_right = AccessRight.find_by(name: access_right_name)
        item.access_right = access_right if access_right
        puts "Could not find access right '#{access_right_name}'" unless access_right
      end
      if (retention_policy_name = h.delete(:retention_policy))
        retention_policy = RetentionPolicy.find_by(name: retention_policy_name)
        item.retention_policy = retention_policy if retention_policy
        puts "Could not find retention policy '#{retention_policy_name}'" unless retention_policy
      end
    end
  end

end
