class Like < ApplicationRecord
    validates :user_id, presence: true
    validates :word_id, presence: true
    
    belongs_to :user
    belongs_to :word

    paginates_per 10
end
