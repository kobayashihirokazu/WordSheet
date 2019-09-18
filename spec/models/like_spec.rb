require 'rails_helper'

RSpec.describe Like, type: :model do
    it 'is valid if user and post exists' do
        like = FactoryBot.build(:like)
        expect(like).to be_valid
    end
    
    it 'is invalid without user' do
        like = FactoryBot.build(:like, user: nil)
        like.valid?
        expect(like.errors[:user]).to include("を入力してください")
    end
    
    it 'is invalid without word' do
        like = FactoryBot.build(:like, word: nil)
        like.valid?
        expect(like.errors[:word]).to include("を入力してください")
    end

end