module Api
  module V1
    class Root < ::Grape::API
      version 'v1', using: :header, vendor: 'libis-teneo', format: :json

      mount Api::V1::Base

    end
  end
end
