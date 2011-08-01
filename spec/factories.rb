FactoryGirl.define do

  sequence :email do |n|
    "user-#{n}@toomuchtodo.com"
  end

  factory :user do
    name "Pablo Lacerda de Miranda"
    email "pablo@toomuchtodo.com"
    password "123456"
    password_confirmation "123456"
  end

  factory :todo_list do
    user
    name "My first List"
    is_private false
  end

  factory :todo_list_item do
    todo_list
    text "Simple task"
  end
end
