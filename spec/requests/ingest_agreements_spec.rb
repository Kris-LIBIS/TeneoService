require 'rails_helper'

RSpec.describe "IngestAgreements", type: :request do
  describe "GET /ingest_agreements" do
    it "works! (now write some real specs)" do
      get ingest_agreements_path
      expect(response).to have_http_status(200)
    end
  end
end
