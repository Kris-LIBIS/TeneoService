# require 'roar/decorator'
# require 'roar/json/json_api'
module Api
  module V1
    class UserRepresenter < ApiRepresenter['users']

      # include Roar::JSON::JSONAPI.resource :users

      # type :users
      #
      # property :id, type: String

      attributes do
        property :email
        property :first_name
        property :last_name
      end

      # has_many :organizations, extend: OrganizationRepresenter

      collection_representer! class: User
    end
  end
end