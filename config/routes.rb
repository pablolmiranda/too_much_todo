Toomuchtodo::Application.routes.draw do

  resources :profile, :only => [ :show ] do
    resources :task_lists, :controller => "profile/task_lists" do
      member do
	post :follow
	delete :unfollow
      end
    end 
  end

  get "site/index"

  devise_for :users

  match "/sign_in", :to => redirect("/users/sign_in")
  match "/sign_up", :to => redirect("/users/sign_up")
  root :to => "site#index"
end
