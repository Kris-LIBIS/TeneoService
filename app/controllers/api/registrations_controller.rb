module Api
  class RegistrationsController < Devise::RegistrationsController
    protect_from_forgery with: :null_session
    respond_to :json

    def create
      build_resource(sign_up_params)

      resource.save
      render_resource(resource)
    end

    def render_resource(resource)
      if resource.errors.empty?
        render json: resource
      else
        validation_error(resource)
      end
    end

    def validation_error(resource)
      render json: {
          errors: [
              {
                  status: '400',
                  title: 'Bad Request',
                  detail: resource.errors,
                  code: '100'
              }
          ]
      }, status: :bad_request
    end

  end
end
