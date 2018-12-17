module Api
  module V1
    class Root < ::Grape::API
      version 'v1', using: :header, vendor: 'libis-teneo', format: :json

      before do
        authenticate!
      end

      mount Api::V1::Users
      mount Api::V1::Organizations
    end
  end
end
