require 'rails_helper'
RSpec.describe "UsersController", type: :request do
  describe "Users Controller showの機能テスト" do
    let!(:user) { create(:user) }

    before do
      sign_in(user)
      get user_path user.id
    end

    it "users/showに正常にアクセスできる" do
      expect(response).to have_http_status(:ok)
    end

    it "@userが取得できている" do
      expect(assigns(:user)).to eq user
    end

    it "userのデータが表示されている" do
      expect(response.body).to include user.user_name
    end
  end
end
