FactoryGirl.define do
  factory :user do
    name "Pablo Lacerda de Miranda"
    email "pablo@toomuchtodo"
    password "123456"
    password_confirmation "123456"
  end

  factory :todo_list do
    name "My first List"
    is_private true
  end
end
