require 'roar/decorator'
require 'roar/json'

module Api
  module V1
    class OrganizationRepresenter < ApiRepresenter['organizations']

      type :organizations

      attributes do
        property :name
        property :description
        property :inst_code
        property :ingest_dir
        property :upload_areas
      end

      has_one :producer, extend: ProducerRepresenter

    end
  end
end