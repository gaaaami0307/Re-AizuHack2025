FactoryBot.define do
  factory :task do
    date { "2025-06-19" }
    content { "MyString" }
    complete { false }
  end
end
