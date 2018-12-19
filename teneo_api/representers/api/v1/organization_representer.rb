require 'roar/decorator'
require 'roar/json'

module Api
  module V1
    class OrganizationRepresenter < ApiRepresenter

      property :id
      property :name
      property :description
      property :inst_code
      property :ingest_dir
      property :upload_areas

      property :producer, decorator: ProducerRepresenter

    end
  end
end