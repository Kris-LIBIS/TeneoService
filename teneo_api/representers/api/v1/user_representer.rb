require 'roar/decorator'
require 'roar/json'

module Api
  module V1
    class UserRepresenter < ApiRepresenter

      property :id
      property :email
      property :first_name
      property :last_name

      property :organizations, extend: OrganizationsRepresenter, embedded: true

    end
  end
end