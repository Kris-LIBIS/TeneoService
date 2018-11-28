require 'rails_helper'

RSpec.describe "UploadAreas", type: :request do
  describe "GET /upload_areas" do
    it "works! (now write some real specs)" do
      get upload_areas_path
      expect(response).to have_http_status(200)
    end
  end
end
