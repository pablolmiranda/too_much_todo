require 'spec_helper'

describe Relationship do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @another_user = FactoryGirl.create(:user, :email => "another@toomuchtodo.com")
    @todo_list = FactoryGirl.create(:todo_list, :user_id => @another_user.id)

    @relationship = @user.relationships.build(:todo_list_id => @todo_list.id)
  end

  it "should create a new instance given valid attributes" do
    @relationship.save!
  end

  describe "associations" do

    it "should respond to user" do
      @relationship.should respond_to(:user)
    end

    it "should responde to todo_list" do
      @relationship.should respond_to(:todo_list)
    end
  
  end # associations

end
