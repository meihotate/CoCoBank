# FactoryBot.define do
#   factory :admin do
#     :name {"Test"}
#     sequence :email do |n|
#     {"test_admin#{n}@example.com"}
#   	end
#     :password {"password"}
#   end
# end

FactoryBot.define do
  factory :admin do
    sequence(:name) { |n| "TEST_NAME#{n}"}
    sequence(:email) { |n| "taro#{n}@example.com"}
    password {"password"}
  end
end