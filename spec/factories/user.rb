FactoryBot.define do
  factory :user do
    name { 'テストユーザー' }
    sequence(:email) { |n| "tester#{n}@example.com" }
    password { 'password' }
		trait :with_words do
			after(:create) { |user| create_list(:word, 5, user: user)}
		end

		trait :with_likes do
			after(:create) { |user| create_list(:like, 5, user: user)}
    end

		trait :with_relationships do
			after(:create) { |user| create_list(:relationship, 5, user: user)}
    end
    
	end
end
