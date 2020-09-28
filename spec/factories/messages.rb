FactoryBot.define do
  factory :message do
    content { 'コメント' }
    association :chat
    association :user
  end
end
