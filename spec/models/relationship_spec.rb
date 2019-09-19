require 'rails_helper'

RSpec.describe Relationship, type: :model do
    it 'is valid if user and follow exists' do
        relationship = FactoryBot.build(:relationship)
        expect(relationship).to be_valid
    end
    
    it 'is invalid without user' do
        relationship = FactoryBot.build(:relationship, user: nil)
        relationship.valid?
        expect(relationship.errors[:user]).to include("を入力してください")
    end
    
    it 'is invalid without follow' do
        relationship = FactoryBot.build(:relationship, follow: nil)
        relationship.valid?
        expect(relationship.errors[:follow]).to include("を入力してください")
    end

end