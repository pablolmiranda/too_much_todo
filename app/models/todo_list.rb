class TodoList < ActiveRecord::Base

  belongs_to :user
  has_many :relationships
  has_many :reverse_relationship, 
    :foreign_key => "followed_list_id", 
    :class_name => "Relationship",
    :dependent => :destroy
  has_many :todo_list_items, :dependent => :destroy
  accepts_nested_attributes_for :todo_list_items, :allow_destroy => true

  has_many :followers, 
    :through => :reverse_relationship

  validates :name, :presence => true
  validates :user_id, :presence => true

end
