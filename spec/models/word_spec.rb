require 'rails_helper'

RSpec.describe Word, type: :model do
    it "is valid with name and description" do
        word = FactoryBot.build(:word)
        expect(word).to be_valid
    end
    it 'is invalid without name' do
        word = FactoryBot.build(:word, name: nil)
        word.valid?
        expect(word.errors[:name]).to include("を入力してください")
    end
    
    it 'is invalid without description' do
        word = FactoryBot.build(:word, description: nil)
        word.valid?
        expect(word.errors[:description]).to include("を入力してください")
    end
    
    it 'is invalid without user' do
        word = FactoryBot.build(:word, user: nil)
        word.valid?
        expect(word.errors[:user]).to include("を入力してください")
    end
    
    it 'can have many likes' do
        word = FactoryBot.create(:word, :with_likes)
        expect(word.likes.length).to eq 5
    end

end