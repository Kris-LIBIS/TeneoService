module Api
  module V1
    class Organizations < ::Grape::API

      resource :organizations do

        desc 'Return list of organizations'
        get do
          Organization.all
        end

      end

    end
  end
end
