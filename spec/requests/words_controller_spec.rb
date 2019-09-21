require 'rails_helper'

RSpec.describe WordsController, type: :controller do
    include Warden::Test::Helpers
    describe "#index" do
        it "responds successfully" do
            get :index
            expect(response).to be_success
        end
    end

    describe "#show" do
        
        before do
            @user = FactoryBot.create(:user)
            @word = FactoryBot.create(:word, user: @user)
        end
        
        context "as a guest" do
            it "responds successfully" do
                get :show, params: { id: @word.id }
                expect(response).to be_success
            end
        end

        context "as an authenticated user" do
            before do
                login_as @user
            end

            it "responds successfully" do
                get :show, params: { id: @word.id }
                expect(response).to be_success
            end
        end
    end

    describe "#create" do
        context "as an authenticated user" do
            before do 
                @user = FactoryBot.create(:user)
                login_as @user
            end

            context "with valid attributes" do
                it "adds a word" do
                    word_params = FactoryBot.attributes_for(:word, user:@user)
                    expect{
                        post :create, params: { word: word_params }
                    }.to change{Word.count}.by(1)
                end
            end

            context "with invalid attributes" do
                it "does not add a word" do
                    word_params = FactoryBot.attributes_for(:word, :invalid)
                    expect {
                        post :create, params: { word: word_params }
                    }.to_not change{Word.count}
                end
            end
        end
        
        context "as a user not to login" do
            before do 
                @user = FactoryBot.create(:user)
            end
            it "redirects to the sign-in page" do
                word_params = FactoryBot.attributes_for(:word)
                post :create, params: { word:word_params }
                expect(response).to redirect_to login_path
            end
        end
    end

    describe "#update" do
        context "if logged in user updates another user" do
            before do
                @user = FactoryBot.create(:user)
                other_user = FactoryBot.create(:user)
                @word = FactoryBot.create(:word, user: other_user, name: "Same Old Name")
            end
            
            it "does not update the word" do
                word_params = FactoryBot.attributes_for(:word, name: "New Name")
                login_as @user
                patch :update, params: { id: @word.id, word: word_params }
                expect(@word.reload.name).to eq "Same Old Name"
            end
            
            it "redirects to the sign-in page" do
                word_params = FactoryBot.attributes_for(:word)
                login_as @user
                patch :update, params: { id: @word.id, word: word_params }
                expect(response).to redirect_to login_path
            end
        end

        context "as a user not to login" do
            before do
                @word = FactoryBot.create(:word)
            end
            
            it "redirects to the sign-in page" do
                word_params = FactoryBot.attributes_for(:word)
                patch :update, params: { id: @word.id,word: word_params }
                expect(response).to redirect_to login_path
            end 
        end
    end

    describe "#destroy" do
        context "as an authenticated user" do
            before do 
                @user = FactoryBot.create(:user)
                @word = FactoryBot.create(:word, user: @user)
                login_as @user
            end

            it "deletes a word" do
                expect {
                    delete :destroy, params: { id: @word.id }
                }.to change{Word.count}.by(1)
            end
        end
        context "if logged in user deletes another user" do
            before do
                @user = FactoryBot.create(:user)
                other_user = FactoryBot.create(:user)
                @word = FactoryBot.create(:word, user: other_user)
            end
            
            it "does not delete the word" do
                login_as @user
                expect {
                    delete :destroy, params: { id: @word.id }
                }.to_not change{Word.count}
            end
            
            it "redirects to the sign-in page" do
                login_as @user
                delete :destroy, params: { id: @word.id }
                expect(response).to redirect_to login_path
            end 
        end
        
        context "as a user not to login" do
            before do
                @word = FactoryBot.create(:word)
            end
        
            it "redirects to the sign-in page" do
                delete :destroy, params: { id: @word.id }
                expect(response).to redirect_to login_path
            end
        
            it "does not delete the word" do
                expect {
                    delete :destroy, params: { id: @word.id }
                }.to_not change{Word.count}
            end
        end 
    end    
end