require 'spec_helper'

feature "Site sign in", %q{
  In order to access site private area
  As a user
  I want to authenticate on TooMuchToDo
} do

  background do
    @user = FactoryGirl.create(:user)
  end

  scenario "Check sign in path" do
    visit "/sign_in"
    page.should have_selector("h2", :content => "Sign in")
  end

  scenario "Site sign in" do
    visit "/sign_in"
    fill_in "Email", :with => @user.email
    fill_in "Password", :with => @user.password
    click_button "Sign in"
    page.should have_selector("div.notice", :content => "You have signed up successfully")
  end
end

feature "Site sign up", %q{
  In order to be part of TooMuchToDo
  As a visitant
  I want to register on TooMuchToDo
} do

  background do
    @attr = FactoryGirl.attributes_for(:user)
    @avatar = "#{::Rails.root.to_s}/spec/fixtures/avatar.jpg"
  end

  scenario "Check sign up path" do
    visit "/sign_up"
    page.should have_selector("h2", :content => "Sign up")
  end

  scenario "Site sign up" do
    visit "/sign_up"
    fill_in "Name", :with => @attr[:name]
    attach_file("Avatar", @avatar)
    fill_in "Email", :with => @attr[:email]
    fill_in "Password", :with => @attr[:password]
    fill_in :user_password_confirmation, :with => @attr[:password_confirmation]
    click_button "Sign up"
    page.should have_selector("div.notice", :content => "You have signed up successfully" )
  end
end

describe "the signup process" do
  
  describe "sign up" do

    describe "fail" do
      
      it "not sign up without any user information" do
	visit "/sign_up"
	click_button "Sign up"
	page.should have_selector("p.error_notification", :content => "Some errors were found, please take a look")
      end 
  
    end #fail
    
    describe "success" do
      before(:each) do
	@attr = FactoryGirl.attributes_for(:user)
      end
    
    end #"success"

  end # sign up

  describe "sign_in path" do

    it "/sign_in redirect to /users/sign_in" do
      visit "/sign_in"
      page.should have_selector("h2", :content => "Sign in")
    end

    describe "fail" do
      it "not sign me in with no information" do
	visit "/sign_in"
	click_button "Sign in"
	page.should have_selector("div.notice", :content => "Invalid email and password")
      end

      it "not sign me in with empty password" do
	visit "/sign_in"
	fill_in "Email", :with => "teste@teste.com"
	click_button "Sign in"
	page.should have_selector("div.notice", :content => "Invalid email and password")
      end # not sign me in with empty password

    end # fail

    describe "success" do
      before(:each) do
	@user = FactoryGirl.create(:user)
      end

      it "sign me in with right information" do
	visit "/sign_in"
	fill_in "Email", :with => @user.email
	fill_in "Password", :with => @user.password
	click_button "Sign in"
	page.should have_selector("p", :content => "You have signed up successfully")
      end 
    end

  end # sign_in path

  describe "sign out" do
    
    describe "success" do

      before(:each) do
	integration_sign_in(FactoryGirl.create(:user))
      end
      
      it "sign out a signed in user" do
	visit "/"
	click_link "Sign out"
	page.should have_selector("div.notice", :content => "Signed out successfully")
      end
      
    end # sucess

  end # sign out

end
