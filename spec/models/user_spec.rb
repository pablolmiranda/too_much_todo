require 'spec_helper'

describe User do

  it "should respond to name" do
    User.should respond_to(:name)
  end

  describe "validations" do
    
    before(:each) do
      @attr = {:name => "Pablo Lacerda de Miranda", :email => "pablo@toomuchtodo.com",
	:password => "123456" }
    end

    it "should require a name" do
      @user = User.new(@attr.merge!(:name => ""))
      @user.should_not be_valid
    end

  end # validations

  describe "todo list association" do
    
    before(:each) do
      @user = FactoryGirl.create(:user)
    end

    it "should respond to todo_lists" do
      @user.should respond_to(:todo_lists)
    end

  end # todo list association
end
