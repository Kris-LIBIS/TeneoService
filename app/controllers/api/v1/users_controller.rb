# frozen_string_literal: true

module Api
  module V1

    class UsersController < Controller
=begin
      # Mark this as a JSONAPI controller, associating with the given resource
      jsonapi resource: V1::UserResource
=end

      before_action :set_user, only: [:index, :show, :organizations, :update, :destroy]

      # GET /users
      def index
        @users = User.all

        render json: @users
=begin
        render_jsonapi(User.where(id: @user.id))
=end
      end

      # GET /users/1
      def show
        render json: @organization
=begin
        raise JsonapiCompliable::Errors::RecordNotFound unless params[:id] == @user.id
        render_jsonapi(@user, scope: false)
        # scope = jsonapi_scope(User.where(id: params[:id]))
=end
=begin
        instance = scope.resolve.first
        raise JsonapiCompliable::Errors::RecordNotFound unless instance
        render_jsonapi(instance, scope: false)
=end
      end

      # POST /users
      def create
        @user = User.new(user_params)

        if @user.save
          render json: @user, status: :created, location: @user
        else
          render json: @user.errors, status: :unprocessable_entity
        end
=begin
        user, success = jsonapi_create.to_a

        if success
          render_jsonapi(user, scope: false)
        else
          render_errors_for(user)
        end
=end
      end

      # PATCH/PUT /users/1
      def update
        if user_params[:password].blank? ?
               @user.update_without_password(user_params)
               : @user.update(user_params)
          render json: @user
        else
          render json: @user.errors, status: :unprocessable_entity
        end
=begin
        user, success = jsonapi_update.to_a

        if success
          render_jsonapi(user, scope: false)
        else
          render_errors_for(user)
        end
=end
      end

      # DELETE /users/1
      def destroy
        @user.destroy
=begin
        user, success = jsonapi_destroy.to_a

        if success
          render json: {meta: {}}
        else
          render_errors_for(user)
        end
=end
      end

      # GET /users/1/organizations
      def organizations
        render json: @user.organizations
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_user
        # noinspection RubyResolve
        @user = current_user
      end

      # Only allow a trusted parameter "white list" through.
      def user_params
        # params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmed)
        params.require(:user).permit(:email, :first_name, :last_name, :password)
      end
    end
  end
end
