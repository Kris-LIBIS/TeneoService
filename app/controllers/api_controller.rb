# frozen_string_literal: true

class ApiController < ActionController::API
  include ActionController::MimeResponds

  respond_to :json

  before_action :authenticate_user!
  #
  # def check_authorization(role, organization)
  #   current_user.is_authorized?(role, organization)
  # end

  # def render_resource(resource)
  #   if resource.errors.empty?
  #     render json: resource
  #   else
  #     validation_error(resource)
  #   end
  # end
  #
  # def validation_error(resource)
  #   render json: {
  #       errors: [
  #           {
  #               status: '400',
  #               title: 'Bad Request',
  #               detail: resource.errors,
  #               code: '100'
  #           }
  #       ]
  #   }, status: :bad_request
  # end

end
