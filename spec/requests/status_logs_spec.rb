require 'rails_helper'

RSpec.describe "StatusLogs", type: :request do
  describe "GET /status_logs" do
    it "works! (now write some real specs)" do
      get status_logs_path
      expect(response).to have_http_status(200)
    end
  end
end
