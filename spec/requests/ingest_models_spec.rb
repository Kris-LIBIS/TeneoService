require 'rails_helper'

RSpec.describe "IngestModels", type: :request do
  describe "GET /ingest_models" do
    it "works! (now write some real specs)" do
      get ingest_models_path
      expect(response).to have_http_status(200)
    end
  end
end
