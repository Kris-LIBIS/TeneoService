module Api::Helpers::StatusHelper
  extend Grape::API::Helpers

  def api_error(code, message)
    error!(message, code)
  end

  def api_success(message = nil)
    status 200
    {message: message}
  end

  def guard
    yield
  rescue ActiveRecordError => e
    api_error(400, e.message)
  end

end