# frozen_string_literal: true

module Api
  module V1

    class UserTokenController < Knock::AuthTokenController
      skip_before_action :verify_authenticity_token

      private

      def auth_params
        params.require(:auth).permit :email, :username, :password
      end

    end
  end
end
