# frozen_string_literal: true

class IngestModel < ApplicationRecord
  has_many :instances, class_name: 'IngestModel', foreign_key: 'template_id'
  belongs_to :template, class_name: 'IngestModel'
end
