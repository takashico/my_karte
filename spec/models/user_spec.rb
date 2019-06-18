require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { create(:user) }

  context "userが正常に登録された場合" do
    it "全ての値が入っている場合" do
      expect(user).to be_valid
    end
  end

  context "userが登録できない場合" do
    it "user_nameが空白の時" do
      user.user_name = " "
      expect(user).not_to be_valid
    end
    it "user_nameが51文字以上の時" do
      user.user_name = "a" * 50
      expect(user).to be_valid
      user.user_name = "a" * 51
      expect(user).not_to be_valid
    end
    it "emailが空白の時" do
      user.email = " "
      expect(user).not_to be_valid
    end
    it "facebook認証できていない時" do
      user.provider = nil
      user.uid = nil
      expect(user).not_to be_valid
    end
  end
end
