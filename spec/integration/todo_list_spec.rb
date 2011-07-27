require 'spec_helper'

feature "Create ToDo list", %q{
  In order to organize the things I have to do
  As a user
  I want to create a to do list
} do
  
  background do
    @user = FactoryGirl.create(:user)
    integration_sign_in(@user)
  end

  scenario "Checking list create path" do
    visit new_profile_task_list_path(@user)
    page.should have_selector("h2", :content => "Create list")
  end

  scenario "Create a ToDo list" do
    visit new_profile_task_list_path(@user)    
    fill_in "Name", :with => "My first list"
    click_button "Create"
    page.should have_selector("div.notice", :content => "Todo list was successfully created")
  end
  
end

feature "Show remove link", %q{
  In order to remove a todo list without followers
  As a user
  I want to see the todo list remove link
} do

  background do
    @user = FactoryGirl.create(:user)
    @todo_list = FactoryGirl.create(:todo_list, :user_id => @user.id)
    integration_sign_in(@user)
  end

  scenario "Show todo list remove link" do
    visit profile_task_list_path(@user, @todo_list)
    page.should have_selector("a#delete_list-#{@todo_list.id}", :href => profile_task_list_path(@user, @todo_list), :content => "Delete")
  end

  scenario "Show todo list remove link after all user unfollow the todo list" do
    @another_user = FactoryGirl.create(:user, :email => "another@toomuchtodo.com")
    @another_user.follow!(@todo_list)
    visit profile_task_list_path(@user, @todo_list)
    page.should_not have_selector("a#delete_list-#{@todo_list.id}", :href => profile_task_list_path(@user, @todo_list), :content => "Delete")

    @another_user.unfollow!(@todo_list)
    visit profile_task_list_path(@user, @todo_list)
    page.should have_selector("a#delete_list-#{@todo_list.id}", :href => profile_task_list_path(@user, @todo_list), :content => "Delete")
  end

end

feature "Don't show remove link", %q{
  In order to protect a todo list with followers
  As a user
  I don't want to see the todo list remove link
} do

  background do
    @user = FactoryGirl.create(:user)
    @todo_list = FactoryGirl.create(:todo_list, :user_id => @user.id)
    @another_user = FactoryGirl.create(:user, :name => "Another User", :email => "another@toomuchtodo.com")
    @another_user.follow!(@todo_list)
    integration_sign_in(@user)
  end

  scenario "Don't show todo list remove link" do
    visit profile_task_list_path(@user, @todo_list)
    page.should_not have_selector("a#delete_list-#{@todo_list.id}", :href => profile_task_list_path(@user, @todo_list), :content => "Delete")
  end

end

feature "Show List", %q{
  In order to see my tasks 
  As a user
  I want to see my list
} do

  background do
    @user = FactoryGirl.create(:user)
    @todo_list = FactoryGirl.create(:todo_list, :user_id => @user.id, :is_private => true)
    @another_user = FactoryGirl.create(:user, :name => "Another User", :email => "another@toomuchtodo.com")
  end

  scenario "Show the tasks on my list" do
    integration_sign_in(@user)
    visit profile_task_list_path(@user, @todo_list)
    page.should have_selector("h2", :content => @todo_list.name)
  end 

  scenario "Don't show my private list to anyone" do
    integration_sign_in(@another_user)
    visit profile_task_list_path(@user, @todo_list)
    page.should have_content("You can't access this list")
  end

end
