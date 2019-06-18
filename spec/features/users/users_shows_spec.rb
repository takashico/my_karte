require 'rails_helper'

RSpec.feature "UsersShows", type: :feature do
  feature "ユーザー個別ページを見ることができる" do
    given!(:user) { create(:user) }
    background do
      sign_in(user)
      visit user_path user.id
    end

    scenario "ユーザー名、プロフィール画像の情報が表示される" do
      expect(page).to have_content user.user_name
    end

    scenario "プロフィール編集をクリック時、編集ページへ移動する" do
      within "#header_menu" do
        click_on "プロフィール編集"
      end
      expect(page).to have_current_path edit_user_registration_path
    end
  end
end
