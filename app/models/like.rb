class Like < ApplicationRecord
    validates :user_id, presence: true
    validates :word_id, presence: true
end
