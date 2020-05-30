FactoryBot.define do
  factory :user_form_message do
    user_form
    name { Faker::Name.name }
    email { "#{Faker::Name.name}@example.com" }
    message { Faker::Lorem.sentences(number: 3) }
  end
end
