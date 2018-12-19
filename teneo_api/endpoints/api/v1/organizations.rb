module Api
  module V1
    class Organizations < ::Grape::API

      resource :organizations do

        desc 'Return list of organizations'
        get do
          present Organization.all, with: OrganizationsRepresenter
        end

      end

    end
  end
end
