Toomuchtodo::Application.routes.draw do

  resources :profile, :only => [ :show ]
  get "site/index"

  devise_for :users

  resources :users do 
    resources :task_list, :controller => "users/task_list"
  end

  resources :task_list do
    member do
      get :follow, :unfollow
    end
  end

  match "/sign_in", :to => redirect("/users/sign_in")
  match "/sign_up", :to => redirect("/users/sign_up")
  root :to => "site#index"
end
