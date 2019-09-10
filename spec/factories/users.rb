FactoryGirl.define do
  factory :user do
    name "Test"
    sequence :email do |n|
    "test_user#{n}@example.com"
  	end
    sex 0
    location 0
    degree 0
    approved 1
    password "password"
  end
end