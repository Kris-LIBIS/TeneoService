require "rails_helper"

RSpec.describe CodeTablesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/code_tables").to route_to("code_tables#index")
    end

    it "routes to #show" do
      expect(:get => "/code_tables/1").to route_to("code_tables#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/code_tables").to route_to("code_tables#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/code_tables/1").to route_to("code_tables#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/code_tables/1").to route_to("code_tables#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/code_tables/1").to route_to("code_tables#destroy", :id => "1")
    end
  end
end
