require 'spec_helper'

describe TodoList do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @attr = FactoryGirl.attributes_for(:todo_list)

  end

  it "should create a new instance given valid attributes" do
    @user.todo_lists.create!(@attr)
  end

  it "should require a user id"
    @
  end

  describe "user association" do

    before(:each) do
      @todo_list = @user.todo_lists.create!(@attr)
    end

    it "should respond to user" do
      @todo_list.should respond_to(:user)
    end

    it "should reference the right user" do
      @todo_list.user_id.should == @user.id
      @todo_list.user.should == @user
    end

  end # user association

end
