require 'rails_helper'

RSpec.describe User, type: :model do
    it "is valid with name, email and password" do
        user = FactoryBot.build(:user)
        expect(user).to be_valid
    end
    it 'is invalid without name' do
        user = FactoryBot.build(:user, name: nil)
        user.valid?
        expect(user.errors[:name]).to include("を入力してください")
    end
    
    it 'is invalid without email' do
        user = FactoryBot.build(:user, email: nil)
        user.valid?
        expect(user.errors[:email]).to include("を入力してください")
    end
    
    it 'is invalid without password' do
        user = FactoryBot.build(:user, password: nil)
        user.valid?
        expect(user.errors[:password]).to include("を入力してください")
    end

    it 'is invalid if email is already taken' do
        FactoryBot.create(:user, email: 'duplicate@email.com')
        user = FactoryBot.build(:user, email: 'duplicate@email.com')
        user.valid?
        expect(user.errors[:email]).to include("はすでに存在します")
    end

    it 'can have many words' do
        user = FactoryBot.create(:user, :with_words)
        expect(user.words.length).to eq 5
    end
    
    it 'can have many likes' do
        user = FactoryBot.create(:user, :with_likes)
        expect(user.likes.length).to eq 5
    end

    it 'can have many relationships' do
        user = FactoryBot.create(:user, :with_relationships)
        expect(user.relationships.length).to eq 5
    end


end