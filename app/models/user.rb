class User < ApplicationRecord
    has_secure_password
  
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true

    has_one_attached :image
    has_many :words, :dependent => :destroy
    has_many :likes, :dependent => :destroy
    has_many :relationships, :dependent => :destroy
    has_many :followings, through: :relationships, source: :follow
    has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
    has_many :followers, through: :reverse_of_relationships, source: :user
    
    paginates_per 10

    def follow(other_user)
      unless self == other_user
        self.relationships.find_or_create_by(follow_id: other_user.id)
      end
    end
  
    # def unfollow(other_user)
    #   relationship = self.relationships.find_by(follow_id: other_user.id)
    #   relationship.destroy if relationship
    # end
  
    def following?(other_user)
      self.followings.include?(other_user)
    end

    def count_words
      self.words.count
    end

    def count_followers
      self.followers.count
    end

    def count_followings
      self.followings.count
    end
end
