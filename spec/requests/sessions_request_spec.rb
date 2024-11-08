require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  before do
    @user = FactoryBot.create(:user) # 必要な場合、Factoryのユーザーを作成
    sign_in @user  # Deviseのsign_inヘルパーを使用
  end

  describe "GET /new" do
    it "returns http success" do
      get "/sessions/new"
      expect(response).to have_http_status(:success)
    end
  end

end
