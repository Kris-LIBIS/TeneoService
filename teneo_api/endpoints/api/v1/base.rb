module Api
  module V1
    class Base < ::Grape::API

      before do
        authenticate!
      end

      mount Api::V1::Users
      mount Api::V1::Organizations

    end
  end
end
