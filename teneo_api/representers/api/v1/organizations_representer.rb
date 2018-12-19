require 'roar/decorator'
require 'roar/json'

module Api
  module V1
    class OrganizationsRepresenter < ApiRepresenter

      # collection :entries, extend: ::Api::V1::OrganizationRepresenter, as: :organizations, embedded: true
      collection :entries, class: Organization do
        property :id
        property :name
        property :inst_code
      end

    end
  end
end