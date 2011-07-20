require 'spec_helper'

describe Relationship do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @another_user = FactoryGirl.create(:user, :email => "another@toomuchtodo.com")
    @todo_list = FactoryGirl.create(:todo_list, :user_id => @another_user.id)

    @relationship = @user.relationships.build(:followed_list_id => @todo_list.id)
  end

  it "should create a new instance given valid attributes" do
    @relationship.save!
  end

  describe "follow methods" do
    before(:each) do
      @relationship.save
    end

    it "should follower attribute" do
      @relationship.should respond_to(:follower)
    end

    it "should have the right follower user" do
      @relationship.follower.should == @user
    end

    it "should have the followed_list attribute" do
      @relationship.should respond_to(:followed_list)
    end

    it "should have the right followed todo list" do
      @relationship.followed_list.should == @todo_list
    end

  end

end
