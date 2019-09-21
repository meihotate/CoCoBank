# FactoryBot.define do
#   factory :user do
#     name "Test"
#     sequence :email do |n|
#     "test_user#{n}@example.com"
#   	end
#     sex 0
#     location 0
#     degree 0
#     approved 1
#     password "password"
#   end
# end

FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "TEST_user#{n}"}
    sequence(:email) { |n| "user#{n}@example.com"}
    sex {0}
    location {0}
    degree {0}
    approved {1}
    password {"password"}
  end
  factory :children, class: User do
    sequence(:name) { |n| "TEST_user#{n}"}
    sequence(:email) { |n| "children#{n}@example.com"}
    sex {0}
    location {0}
    degree {0}
    approved {0}
    password {"password"}
  end
  factory :counselor, class: User do
    sequence(:name) { |n| "TEST_counselor#{n}"}
    sequence(:email) { |n| "counselor#{n}@example.com"}
    sex {0}
    location {0}
    degree {0}
    approved {2}
    password {"password"}
  end
end