module Api::V1
  class Users < ::Grape::API
    include Api::Endpoint

    resource :users do

      helpers Api::Helpers::ParamHelper
      helpers Api::Helpers::StatusHelper
      helpers Api::Helpers::PresentationHelper
      helpers Api::Helpers::PaginationHelper

      desc 'Return list of users'
      paginate per_page: 10, max_per_page: 40
      params do
        use :user_fields
      end
      get do
        present policy_scope(User), with: UserRepresenter
      end

      desc 'Return complete list of users'
      get 'all' do
        present User.all, with: Api::V1::UserRepresenter
        # noinspection RubyArgCount
        # Api::V1::UsersRepresenter.new(User.all).represent
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
