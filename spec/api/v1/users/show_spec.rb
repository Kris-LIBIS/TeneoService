=begin
require 'rails_helper'

RSpec.describe "api/v1/users#show", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/users/#{user.id}",
      params: params
  end

  describe 'basic fetch' do
    let!(:user) { create(:user) }

    it 'serializes the resource correctly' do
      make_request
      assert_payload(:user, user, json_item)
    end
  end
end
=end
