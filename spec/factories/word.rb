FactoryBot.define do
  factory :word do
	name { 'テスト' }
	description { 'テスト投稿' }
  association :user
	trait :with_likes do
		after(:create) { |word| create_list(:like, 5, word: word)}
	end
  end
end
