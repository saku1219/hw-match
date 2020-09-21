FactoryBot.define do
  factory :user do
    nickname { Faker::Name.last_name }
    email { Faker::Internet.free_email }
    password { 'TESTtest1234' }
    password_confirmation { password }
    tel { '09012345678' }
  end
end
