require 'hashie'
require 'grape/extensions/hashie/mash'

module Api
  class Root < ::Grape::API
    include Grape::Extensions::Hashie::Mash::ParamBuilder

    prefix 'api'
    # noinspection RubyResolve
    # error_formatter :json, ::Api::ErrorFormatter

    helpers Pundit

    helpers do

      def warden
        env['warden']
      end

      def authenticate!
        warden.authenticate!
      end

      def authenticated?
        warden.authenticated?
      end

      def current_user
        warden.user
      end
    end

    format :json
    formatter :json, Grape::Formatter::Roar

    mount ::Api::V1::Root
  end
end
