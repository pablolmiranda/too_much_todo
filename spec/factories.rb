FactoryGirl.define do
  factory :user do
    name "Pablo Lacerda de Miranda"
    email "pablo@toomuchtodo"
    password "123456"
    password_confirmation "123456"
  end

  factory :todo_list do
    user_id FactoryGirl.create(:user).id
    name "My first List"
    is_private false
  end

  factory :todo_list_item do
    todo_list_id FactoryGirl.create(:todo_list).id
    text "Simple task"
  end
end
