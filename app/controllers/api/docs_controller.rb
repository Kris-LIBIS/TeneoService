=begin
require 'jsonapi_swagger_helpers'

module Api
  class DocsController < ActionController::API
    include JsonapiSwaggerHelpers::DocsControllerMixin

    swagger_root do
      key :swagger, '2.0'
      info do
        key :version, '1.0.0'
        key :title, 'Teneo Service'
        key :description, 'Services web application for Teneo uploads, pre-ingest and ingest'
        contact do
          key :name, 'Libis'
          key :email, 'teneo.libis@gmail.com'
        end
      end
      key :basePath, '/api'
      key :consumes, ['application/json']
      key :produces, ['application/json']
    end

    # jsonapi_resource '/v1/users'
    jsonapi_resource '/users', only: [:index, :show]

  end

end=end
