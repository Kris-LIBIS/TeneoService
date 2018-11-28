require "rails_helper"

RSpec.describe UploadAreasController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/upload_areas").to route_to("upload_areas#index")
    end

    it "routes to #show" do
      expect(:get => "/upload_areas/1").to route_to("upload_areas#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/upload_areas").to route_to("upload_areas#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/upload_areas/1").to route_to("upload_areas#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/upload_areas/1").to route_to("upload_areas#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/upload_areas/1").to route_to("upload_areas#destroy", :id => "1")
    end
  end
end
