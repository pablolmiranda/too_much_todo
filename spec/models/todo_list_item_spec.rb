require 'spec_helper'

describe TodoListItem do
  before(:each) do
    @attr = FactoryGirl.attributes_for(:todo_list_item)
    @todo_list_item = Factory.create(:todo_list_item)
  end

  it "should create a new instance given valid attributes" do
    TodoListItem.create!(@attr)
  end

  it "should respond to todo_list" do
   @todo_list_item.should respond_to(:todo_list) 
  end

end
