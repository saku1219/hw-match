FactoryBot.define do
  factory :work do
    type_id { '2' }
    name { '掃除をお願いします' }
    genre_id { '2' }
    place { '青山' }
    start_time { Faker::Time.between(from: DateTime.now + 2, to: DateTime.now + 3) }
    end_time { Faker::Time.between(from: DateTime.now + 4, to: DateTime.now + 5) }
    description { 'リビングの掃除をお願いします' }
    association :user
  end
end
