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
    visit "/task_list/new"
    page.should have_selector("h2", :content => "Create list")
  end

  scenario "Create a ToDo list" do
    visit "/task_list/new"
    fill_in "Name", :with => "My first list"
    click_button "Create"
    page.should have_selector("div.notice", :content => "Todo list was successfully created")
  end
  
end

feature "Show remove link", %q{
  I order to remove a todo list without followers
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
  I order to protect a todo list with followers
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
