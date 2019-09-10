FactoryGirl.define do
  factory :admin do
    name "Test"
    sequence :email do |n|
    "test_admin#{n}@example.com"
  	end
    password "password"
  end
end