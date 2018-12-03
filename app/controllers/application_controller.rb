# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Knock::Authenticable

  before_action :authenticate_user

  def check_authorization(role, group)
    current_user.is_authorized?(role, group)
  end
end
