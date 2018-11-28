require 'rails_helper'

RSpec.describe "CodeTables", type: :request do
  describe "GET /code_tables" do
    it "works! (now write some real specs)" do
      get code_tables_path
      expect(response).to have_http_status(200)
    end
  end
end
