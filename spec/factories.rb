FactoryGirl.define do
  factory :user do
    name "Pablo Lacerda de Miranda"
    email "pablo@toomuchtodo"
    password "123456"
    password_confirmation "123456"
  end

  factory :todo_list do
    user_id 1
    name "My first List"
    is_private false
  end

  factory :todo_list_item do
    todo_list_id 1
    text "Simple task"
  end
end
