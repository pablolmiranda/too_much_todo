Toomuchtodo::Application.routes.draw do
  devise_for :users

  root :to => "site#index"
end
