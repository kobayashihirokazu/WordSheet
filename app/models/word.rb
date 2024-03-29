class Word < ApplicationRecord
    validates :name, presence: true, length: { maximum: 30 }
    validates :description, presence: true
    validate :validate_name_not_including_comma
  
    belongs_to :user
    has_many :likes, :dependent => :destroy

    scope :recent, -> { order(created_at: :desc) }
  
    paginates_per 10

    def user
      if self.user_id
        User.find(self.user_id)
      end
    end

    def self.ransackable_attributes(auth_object = nil)
      %w[name created_at]
    end

    def self.ransackable_associations(auth_object = nil)
      %[]
    end

    private
  
    def validate_name_not_including_comma
      errors.add(:name, 'にカンマを含めることはできません') if name&.include?(',')
    end


end
