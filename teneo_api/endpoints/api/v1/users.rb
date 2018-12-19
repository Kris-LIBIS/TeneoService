module Api
  module V1
    class Users <  ::Grape::API

      resource :users do

        desc 'Return list of users'
        get do
          present policy_scope(User), with: UsersRepresenter
        end

        desc 'Return complete list of users'
        get 'all' do
          present User.all, with: UsersRepresenter
        end

        desc 'Get info for a given user'
          params do
            requires :id, type: String, desc: 'User id'
          end
        get ':id' do
          user = User.find_by(id: params.id)
          present user, with: UserRepresenter
        end

      end

    end
  end
end
