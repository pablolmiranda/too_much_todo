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
