# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Knock::Authenticable

  before_action :authenticate_user

  def check_authorization(role, organization)
    current_user.is_authorized?(role, organization)
  end
end
