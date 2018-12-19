require 'roar/decorator'
require 'roar/json'

module Api
  module V1
    class UsersRepresenter < ApiRepresenter

      collection :users, class: User do
        property :id
        property :email
        property :first_name
        property :last_name
      end

    end
  end
end