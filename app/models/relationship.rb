class Relationship < ActiveRecord::Base
  belongs_to :follower, :class_name => "User"
  belongs_to :followed_list, :class_name => "TodoList"
end
