Toomuchtodo::Application.routes.draw do

  resources :profile do
    resources :task_list, :controller => "profile/task_list"
    member do
      get :show
    end
  end

  get "site/index"

  devise_for :users

  resources :task_list do
    member do
      get :follow, :unfollow
    end
  end

  match "/sign_in", :to => redirect("/users/sign_in")
  match "/sign_up", :to => redirect("/users/sign_up")
  root :to => "site#index"
end
