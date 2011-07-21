require 'spec_helper'

feature "User profile", %q{
  In order to see the user information
  As a visitant
  I want to see the user profile
} do

  background do
    @user = FactoryGirl.create(:user)
  end

  scenario "User profile" do
    visit "/profile/#{@user.id}"
    page.should have_selector("h2", :content => @user.name)
  end

end

feature "Show todo list follow link", %q{
  In order to follow a another User todo list
  As a user
  I want to see the follow link
} do

  background do
    @user = FactoryGirl.create(:user)
    @another_user = FactoryGirl.create(:user, :name => "Another User", :email => "another@toomuchtodo.com")
    @first_list = FactoryGirl.create(:todo_list, :user_id => @another_user.id )
    integration_sign_in(@user)
  end

  scenario "Show ToDo list follow link" do
    visit profile_path(@another_user)
    page.should have_selector("a#list-#{@first_list.id}", :href => follow_task_list_path(@first_list), :content => "follow")
  end
end

feature "Show todo list unfollow link", %q{
  In order to unfollow a another User todo list
  As a user followed another user todo list
  I want to see the unfollow link for the todo list
} do

  background do
    @user = FactoryGirl.create(:user)
    @another_user = FactoryGirl.create(:user, :email => "another@toomuchtodo.com")
    @first_list = FactoryGirl.create(:todo_list, :user_id => @another_user.id )
    @user.follow!(@first_list)
    integration_sign_in(@user)
  end

  scenario "Show unfollow todo list link" do
    visit profile_path(@another_user)
    page.body.should have_selector("a#list-#{@first_list.id}", :href => unfollow_task_list_path(@first_list), :content => "Unfollow")
  end
end # Show todo list unfollow link

feature "Don't show todo list follow link", %q{
  In order to see my ToDo lists
  As a user
  I don't want to see the follow link
} do

  background do
    @user = FactoryGirl.create(:user)
    @first_list = FactoryGirl.create(:todo_list, :user_id => @user.id )
    integration_sign_in(@user)
  end

  scenario "Don`t show follow todo list link" do
    visit profile_path(@user)
    page.should_not have_selector("a#list-#{@first_list.id}", :content => "follow")
  end
end

