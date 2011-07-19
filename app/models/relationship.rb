class Relationship < ActiveRecord::Base
  belongs_to :user
  belongs_to :todo_list
end
