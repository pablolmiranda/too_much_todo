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

feature "Show ToDo list follow link", %q{
  In order to follow a another User ToDo list
  As a user
  I want to see the follow link
} do

  background do
    @user = FactoryGirl.create(:user)
    @another_user = FactoryGirl.create(:user, :email => "another@toomuchtodo.com")
    @first_list = FactoryGirl.create(:todo_list, :user_id => @another_user.id )
    integration_sign_in(@user)
  end

  scenario "Show ToDo list follow link" do
    visit profile_path(@another_user)
    page.should have_selector("a#list-#{@first_list.id}", :content => "follow")
  end
end

feature "Don't show ToDo list follow link", %q{
  In order to see my ToDo lists
  As a user
  I don't want to see the follow link
} do

  background do
    @user = FactoryGirl.create(:user)
    @first_list = FactoryGirl.create(:todo_list, :user_id => @user.id )
    integration_sign_in(@user)
  end

  scenario "Show ToDo list follow link" do
    visit profile_path(@user)
    page.should_not have_selector("a#list-#{@first_list.id}", :content => "follow")
  end
end


