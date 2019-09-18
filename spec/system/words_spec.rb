# require 'rails_helper'

# describe 'ワード管理機能', type: :system do
#   let(:user_a) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com') }
#   let(:user_b) { FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com') }
#   let!(:word_a) { FactoryBot.create(:word, name: '最初のワード', user: user_a) }

#   before do
#     visit login_path
#     fill_in 'メールアドレス', with: login_user.email
#     fill_in 'パスワード', with: login_user.password
#     click_button 'ログインする'
#   end

#   shared_examples_for 'ユーザーAが作成したワードが表示される' do
#     it { expect(page).to have_content '最初のワード' }
#   end

#   describe 'ワード一覧表示機能' do
#     context 'ユーザーAがログインしているとき' do
#       let(:login_user) { user_a }

#       it_behaves_like 'ユーザーAが作成したワードが表示される'
#     end

#     context 'ユーザーBがログインしているとき' do
#       let(:login_user) { user_b }

#       it 'ユーザーAが作成したワードが表示されない' do
#         expect(page).to have_no_content '最初のワード'
#       end
#     end
#   end

#   describe 'ワード詳細表示機能' do
#     context 'ユーザーAがログインしているとき' do
#       let(:login_user) { user_a }

#       before do
#         visit word_path(word_a)
#       end

#       it_behaves_like 'ユーザーAが作成したワードが表示される'
#     end
#   end

#   describe '新規作成機能' do
#     let(:login_user) { user_a }
#     let(:word_name) { '新規作成のテストを書く' } # デフォルトとして設定

#     before do
#       visit new_word_path
#       fill_in '名称', with: word_name
#       click_button '登録する'
#     end

#     context '新規作成画面で名称を入力したとき' do
#       it '正常に登録される' do
#         expect(page).to have_selector '.alert-success', text: '新規作成のテストを書く'
#       end
#     end

#     context '新規作成画面で名称を入力しなかったとき' do
#       let(:word_name) { '' }

#       it 'エラーとなる' do
#         within '#error_explanation' do
#           expect(page).to have_content '名称を入力してください'
#         end
#       end
#     end
#   end

#   describe 'ワード更新機能' do
#     let(:login_user) { user_a }
#     let(:word_name) { '更新機能のテストを書く' }

#     before do
#       visit edit_word_path(word_a)
#       fill_in '名称', with: word_name
#       click_button '登録する'
#     end

#     context 'ワード更新画面で名称を入力したとき' do
#       it '正常に登録される' do
#         expect(page).to have_selector '.alert-success', text: '更新機能のテストを書く'
#       end
#     end

#     context 'ワード更新画面で名称を入力しなかったとき' do
#       let(:word_name) { '' }

#       it 'エラーとなる' do
#         within '#error_explanation' do
#           expect(page).to have_content '名称を入力してください'
#         end
#       end
#     end
#   end

#   describe 'ワード消去機能' do
#     let(:login_user) { user_a }

#     before do
#       visit word_path(word_a)
#       click_on '削除'
#       page.driver.browser.switch_to.alert.accept
#     end     

#     context 'ワード詳細画面で消去ボタンを押したしたとき' do
#       it '正常に消去される' do
#         expect(page).to have_selector '.alert-success', text: '最初のワード'
#       end
#     end
#   end

# end
