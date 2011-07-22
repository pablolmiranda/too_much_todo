require 'spec_helper'

describe TodoList do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @attr = FactoryGirl.attributes_for(:todo_list)

  end

  it "should create a new instance given valid attributes" do
    TodoList.create!(@attr)
  end

  it "should require a name" do
    todo_list = TodoList.new(@attr.merge!( :name => ""))
    todo_list.should_not be_valid
  end

  it "should require a user id" do
    todo_list = TodoList.new(@attr.merge!(:user_id => ""))
    todo_list.should_not be_valid
  end

  describe "associations" do

    before(:each) do
      @todo_list = @user.todo_lists.create!(@attr)
    end

    describe "user association" do

      it "should respond to user" do
	@todo_list.should respond_to(:user)
      end

      it "should reference the right user" do
	@todo_list.user_id.should == @user.id
	@todo_list.user.should == @user
      end

    end # user association

    describe "relationship associations" do
      
      it "should respond to relationships" do
	@todo_list.should respond_to(:relationships)
      end

      it "should respond to follwers method" do
	@todo_list.should respond_to(:followers)
      end

      it "should respond to has_followers?" do
	@todo_list.should respond_to(:has_followers?)
      end

      it "should not have any followers" do
	@todo_list.should_not have_followers	
      end

      it "should has followers" do
	another_user = FactoryGirl.create(:user, :email => "another@toomuchtodo.com" )
	another_user.follow!(@todo_list)
	@todo_list.should have_followers
      end
    
    end #relationship associations

    describe "todo list item association" do

      it "should respond to items" do
	@todo_list.should respond_to(:items)
      end

      it "should include the right todo list item" do
	@item = @todo_list.items.create(:text => "Simple task")
	@todo_list.items.should include(@item)
      end

    end # todo list item association

  end # associations

end
