require 'rails_helper'

describe 'ユーザー機能', type: :system do
  let(:user) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com') }
  let(:user_a) { FactoryBot.create(:user, :with_words, :with_likes, :with_relationships) }
  let(:user_b) { FactoryBot.create(:user) }
  let(:relationship_b_a) { FactoryBot.create(:relationship, user: user_b, follow: user_a) }

  context 'ログインしていないとき' do
    describe '新規登録機能' do
      let(:name) { 'test_name' }
      let(:email) { 'test_email' }
      let(:password) { 'test_password' }
      let(:password_confirmation) { 'test_password' }

      before do
        visit new_user_path
        fill_in '名前', with: name
        fill_in 'メールアドレス', with: email
        fill_in 'パスワード', with: password
        fill_in 'パスワード(確認)', with: password_confirmation
        click_button '登録する'
      end

      context '新規登録画面で記入項目すべてを入力したとき' do
        it '正常に登録される' do
          expect(page).to have_selector '.alert-success', text: "ユーザ「#{name}」を登録しました"
        end
      end

      context '新規作成画面で名前を入力しなかったとき' do
        let(:name) { '' }

        it 'エラーとなる' do
          within '#error_explanation' do
            expect(page).to have_content '名前を入力してください'
          end
        end
      end

      context '新規作成画面でメールアドレスを入力しなかったとき' do
        let(:email) { '' }

        it 'エラーとなる' do
          within '#error_explanation' do
            expect(page).to have_content 'メールアドレスを入力してください'
          end
        end
      end

      context '新規作成画面でパスワードを入力しなかったとき' do
        let(:password) { '' }

        it 'エラーとなる' do
          within '#error_explanation' do
            expect(page).to have_content 'パスワードを入力してください'
          end
        end
      end

      context '新規作成画面でパスワードとパスワード(確認)が一致しなかったとき' do
        let(:password_confirmation) { '' }

        it 'エラーとなる' do
          within '#error_explanation' do
            expect(page).to have_content 'パスワード(確認)とパスワードの入力が一致しません'
          end
        end
      end

      context 'メールアドレスがすでに存在するとき' do
        let(:email) { 'a@example.com' }

        it 'エラーとなる' do
          within '#error_explanation' do
            expect(page).to have_content 'メールアドレスはすでに存在します'
          end
        end
      end
    end

    describe 'ユーザ詳細表示機能' do
      let(:show_user) { user_a }
      before do
        visit user_path(show_user)
      end
      it 'ユーザーAの詳細画面が表示される' do
        expect(page).to have_content "#{show_user.name}"
      end
    end

    describe 'ユーザ投稿一覧表示機能' do
      before do
        visit user_path(user_a)
      end
      it 'ユーザーAの投稿一覧が表示される' do
        expect(page).to have_content "#{user_a.words[0].name}"
      end
    end

    describe 'ユーザいいね一覧表示機能' do
      before do
        visit likes_user_path(user_a)
      end
      it 'ユーザーAのいいね一覧が表示される' do
        expect(page).to have_content "#{user_a.likes[0].word.name}"
      end
    end

    describe 'ユーザフォロー一覧表示機能' do
      before do
        visit followings_user_path(user_a)
      end
      it 'ユーザーAのフォロー一覧が表示される' do
        expect(page).to have_content "#{user_a.relationships[0].follow.name}"
      end
    end

    describe 'ユーザフォロワー一覧表示機能' do
      before do
        visit followers_user_path(user_a)
      end
      it 'ユーザーAのフォロワー一覧が表示される' do
        expect(page).to have_content "#{relationship_b_a.user.name}"
      end
    end

  end

  context 'ユーザーAがログインしているとき' do
    before do
      visit login_path
      fill_in 'メールアドレス', with: login_user.email
      fill_in 'パスワード', with: login_user.password
      click_button 'ログイン'
    end

    describe 'ユーザ更新機能' do
      let(:login_user) { user_a }
      let(:name) { 'updated_name' }
      let(:email) { 'updated_email' }

      before do
        visit edit_user_path(login_user)
        fill_in '名前', with: name
        fill_in 'メールアドレス', with: email 
        click_button '登録する'
      end

      context 'ユーザ更新画面で名称を入力したとき' do
        it '正常に登録される' do
          expect(page).to have_selector '.alert-success', text: "ユーザ「#{name}」を更新しました"
        end
      end
    end

    describe 'フォロー機能' do
      let(:login_user) { user_a }
      let(:follow_links) { page.all(".mgr-20") }
      # before do
      #   visit followings_user_path(user_a)
      #   follow_links[0].find_link("フォロー").click
      # end

      # context 'フォローボタンを押したとき' do
      #   it '正常にフォローされる' do
      #     expect(page).to have_selector '.alert-success', text: "ユーザをフォローしました"
      #   end
      # end

      before do
        visit followings_user_path(login_user)
        follow_links[0].click_link("フォロー解除")
      end

      context 'フォロー解除ボタンを押したとき' do
        it '正常にフォロー解除される' do
          expect(page).to have_selector '.alert-success', text: "ユーザーのフォローを解除しました"
        end
      end
    end
    
    describe 'フォロー機能' do
      let(:login_user) { user_a }
      let(:follow_links) { page.all(".mgr-20") }
      # before do
      #   visit followings_user_path(user_a)
      #   follow_links[0].find_link("フォロー").click
      # end

      # context 'フォローボタンを押したとき' do
      #   it '正常にフォローされる' do
      #     expect(page).to have_selector '.alert-success', text: "ユーザをフォローしました"
      #   end
      # end

      before do
        visit followings_user_path(login_user)
        follow_links[0].click_link("フォロー解除")
      end

      context 'フォロー解除ボタンを押したとき' do
        it '正常にフォロー解除される' do
          expect(page).to have_selector '.alert-success', text: "ユーザーのフォローを解除しました"
        end
      end
    end
  end
end