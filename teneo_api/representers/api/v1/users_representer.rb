module Api
  module V1
    class UsersRepresenter < Grape::Roar::Decorator
      include ApiRepresenter

      type :users

      attributes do
        property :email, type: String, desc: 'E-mail address'
        property :first_name, type: String, desc: 'First name'
        property :last_name, type: String, desc: 'Last name'
      end

    end
  end
end