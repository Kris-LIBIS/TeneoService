module Api
  module V1
    class Organizations < ::Grape::API

      resource :organizations do

        desc 'Return list of organizations'
        get do
          present policy_scope(Organization), with: OrganizationsRepresenter
        end

        desc 'Return list of all organizations'
        get 'all' do
          present Organization.all, with: OrganizationsRepresenter
        end

        desc 'Get info for a given organization'
        params do
          requires :id, type: String, desc: 'Organization id'
        end
        get ':id' do
          organization = Organization.find_by(id: params.id)
          present organization, with: OrganizationRepresenter
        end

      end

    end
  end
end
