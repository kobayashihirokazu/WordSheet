FactoryBot.define do
  factory :like do
    association :user
    association :word
  end
end