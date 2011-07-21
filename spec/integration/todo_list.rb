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
    page.should have_selector("p.notice", :content => "Todo list was successfully created")
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

  scenario "Show remove todo list" do
    visit profile_task_list_path(@user, @todo_list)
    page.should have_selector("a", :href => "a#delete_list-#{@todo_list.id}", :content => "Delete")
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
    integration_sign_in(@user)
  end

  scenario "Show remove todo list" do
    visit profile_task_list_path(@user, @todo_list)
    page.should have_selector("a", :href => "a#delete_list-#{@todo_list.id}", :content => "Delete")
  end

end
