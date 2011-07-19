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

  describe "associations" do

    before(:each) do
      @user = FactoryGirl.create(:user)
    end

    describe "todo list association" do
    
      it "should respond to todo_lists" do
	@user.should respond_to(:todo_lists)
      end

    end # todo list association

    describe "relationship association" do

      it "should respond to relationships" do
	@user.should respond_to(:relationships)
      end

    end # relationship association

  end # associations

end
