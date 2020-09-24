FactoryBot.define do
  factory :comment do
    content { 'コメント' }
    association :work
    association :user
  end
end
