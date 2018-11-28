require "rails_helper"

RSpec.describe IngestModelsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/ingest_models").to route_to("ingest_models#index")
    end

    it "routes to #show" do
      expect(:get => "/ingest_models/1").to route_to("ingest_models#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/ingest_models").to route_to("ingest_models#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/ingest_models/1").to route_to("ingest_models#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/ingest_models/1").to route_to("ingest_models#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/ingest_models/1").to route_to("ingest_models#destroy", :id => "1")
    end
  end
end
