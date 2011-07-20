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

      it "should respond to following method" do
	@user.should respond_to(:following)
      end

      it "should respond to follow! method" do
	@user.should respond_to(:follow!)
      end

      it "should respond to following? method" do
	@user.should respond_to(:following?)
      end

      describe "follow/unfollow methods" do
	
	before(:each) do
	  @another_user = FactoryGirl.create(:user, :email => "another@toomuchtodo.com")
	  @todo_list = FactoryGirl.create(:todo_list, :user_id => @another_user.id)
	end

	it "should respond to relationships" do
	  @user.should respond_to(:relationships)
	end

	it "should respond to following method" do
	  @user.should respond_to(:following)
	end

	it "should respond to follow! method" do
	  @user.should respond_to(:follow!)
	end

	it "should respond to following? method" do
	  @user.should respond_to(:following?)
	end

	it "should respond to unfollow! method" do
	  @user.should respond_to(:unfollow!)
	end

        it "should follow the right todo list" do
	  @user.follow!(@todo_list)
	  @user.should be_following(@todo_list)
	end

	it "should include the following todo list in following array" do
	  @user.follow!(@todo_list)
	  @user.following.should include(@todo_list)
	end

	it "should unfollow a todo list" do
	  @user.follow!(@todo_list)
	  @user.unfollow!(@todo_list)
	  @user.should_not be_following(@todo_list)
	end

	it "should include the right follower" do
	  @user.follow!(@todo_list)
	  @todo_list.followers.should include(@user)
	end

      end #follow/unfollow methods

    end # relationship association

  end # associations

end
