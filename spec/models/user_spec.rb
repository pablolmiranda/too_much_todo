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

  end
end
