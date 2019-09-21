require 'rails_helper'

describe '投稿管理機能', type: :system do
  let!(:user_a) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com') }
  let(:user_b) { FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com') }
  let!(:word_a) { FactoryBot.create(:word, name: 'Aの投稿', user: user_a) }
  let!(:word_b) { FactoryBot.create(:word, name: 'Bの投稿', user: user_b) }

  shared_examples_for 'ユーザーAが作成した投稿が表示される' do
    it { expect(page).to have_content 'Aの投稿' }
  end

  context 'ログインしていないとき' do
    describe '投稿一覧表示機能' do
      before do
        visit words_path
      end
      it_behaves_like 'ユーザーAが作成した投稿が表示される'
    end

    describe '投稿詳細表示機能' do
      before do
        visit word_path(word_a)
      end
      it_behaves_like 'ユーザーAが作成した投稿が表示される'
    end
  end

  context 'ユーザーAがログインしているとき' do

    before do
      visit login_path
      fill_in 'メールアドレス', with: login_user.email
      fill_in 'パスワード', with: login_user.password
      click_button 'ログイン'
    end

    describe '新規作成機能' do
      let(:login_user) { user_a }
      let(:word_name) { '新規作成のテストを書く' }
      let(:description_name) { '新規作成のテストの内容を書く' }

      before do
        visit new_word_path
        fill_in '名称', with: word_name
        fill_in '内容', with: description_name
        click_button '登録する'
      end

      context '新規作成画面で名称と内容を入力したとき' do
        it '正常に登録される' do
          expect(page).to have_selector '.alert-success', text: '新規作成のテストを書く'
        end
      end

      context '新規作成画面で名称を入力しなかったとき' do
        let(:word_name) { '' }

        it 'エラーとなる' do
          within '#error_explanation' do
            expect(page).to have_content '名称を入力してください'
          end
        end
      end

      context '新規作成画面で内容を入力しなかったとき' do
        let(:description_name) { '' }

        it 'エラーとなる' do
          within '#error_explanation' do
            expect(page).to have_content '内容を入力してください'
          end
        end
      end
    end

    describe '投稿更新機能' do
      let(:login_user) { user_a }
      let(:word_name) { '更新機能のテストを書く' }

      before do
        visit edit_word_path(word_a)
        fill_in '名称', with: word_name
        click_button '登録する'
      end

      context '投稿更新画面で名称を入力したとき' do
        it '正常に登録される' do
          expect(page).to have_selector '.alert-success', text: '更新機能のテストを書く'
        end
      end

      context '投稿更新画面で名称を入力しなかったとき' do
        let(:word_name) { '' }

        it 'エラーとなる' do
          within '#error_explanation' do
            expect(page).to have_content '名称を入力してください'
          end
        end
      end
    end

    describe '投稿消去機能' do
      let(:login_user) { user_a }

      before do
        visit word_path(word_a)
        click_on '削除'
        page.driver.browser.switch_to.alert.accept
      end     

      context '投稿詳細画面で消去ボタンを押したしたとき' do
        it '正常に消去される' do
          expect(page).to have_selector '.alert-success', text: 'Aの投稿'
        end
      end
    end

    describe 'いいね作成機能' do
      let(:login_user) { user_a }

      before do
        visit word_path(word_b)
        click_link('いいね')
      end     

      context '投稿詳細画面でいいねを押したしたとき' do
        it '正常にいいねされる' do
          expect(page).to have_selector '.alert-success', text: 'いいね'
        end
      end
    end

    describe 'いいね解除機能' do
      let(:login_user) { user_a }

      before do
        FactoryBot.create(:like, user: user_a, word: word_b)
        visit word_path(word_b)
        click_link('いいね解除')
      end     

      context '投稿詳細画面でいいねを押したしたとき' do
        it '正常にいいねが解除される' do
          expect(page).to have_selector '.alert-success', text: 'いいね'
        end
      end
    end


  end
end
