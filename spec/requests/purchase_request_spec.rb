require 'rails_helper'

RSpec.describe "Purchases", type: :request do

  describe "GET /informations" do
    it "returns http success" do
      get "/purchase/informations"
      expect(response).to have_http_status(:success)
    end
  end

end
