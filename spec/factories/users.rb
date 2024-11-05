FactoryBot.define do
  factory :user do
    email { "test@test" }
    password { "password123" }
    password_confirmation { "password123" }
    nickname { "AnotherUser" }
    family_name { "佐藤" }
    first_name { "次郎" }
    family_name_kana { "サトウ" }
    first_name_kana { "ジロウ" }
    birthday { "2000-01-02" }
  end
end