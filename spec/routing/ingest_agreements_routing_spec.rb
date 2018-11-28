require "rails_helper"

RSpec.describe IngestAgreementsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/ingest_agreements").to route_to("ingest_agreements#index")
    end

    it "routes to #show" do
      expect(:get => "/ingest_agreements/1").to route_to("ingest_agreements#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/ingest_agreements").to route_to("ingest_agreements#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/ingest_agreements/1").to route_to("ingest_agreements#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/ingest_agreements/1").to route_to("ingest_agreements#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/ingest_agreements/1").to route_to("ingest_agreements#destroy", :id => "1")
    end
  end
end
