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
