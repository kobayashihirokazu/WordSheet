require 'rails_helper'

describe 'セッション管理機能', type: :system do
  let(:user_a) { FactoryBot.create(:user) }

  describe 'ログイン機能' do
    before do
      visit login_path
    end
    scenario 'ユーザーAがログイン画面で正しい名前とメールアドレスを入力したとき' do
      fill_in 'メールアドレス', with: user_a.email
      fill_in 'パスワード', with: user_a.password
      click_button 'ログイン'
      expect(page).to have_selector '.alert-success', text: 'ログイン'
    end
    
    scenario 'ユーザーAがログイン画面で誤った名前とメールアドレスを入力したとき' do
      fill_in 'メールアドレス', with: ''
      fill_in 'パスワード', with: ''
      click_button 'ログイン'
      expect(page).to have_selector '.alert', text: 'メールアドレスまたはパスワードが間違っています'
    end
  end

  describe 'ログイン機能' do
    before do
      visit login_path
      fill_in 'メールアドレス', with: user_a.email
      fill_in 'パスワード', with: user_a.password
      click_button 'ログイン'
    end
    scenario 'ユーザーAがヘッダーの「ログアウト」を押したとき' do
      visit root_path
      click_on 'ログアウト'
      expect(page).to have_selector '.alert-success', text: 'ログアウト'
    end
  end
end
