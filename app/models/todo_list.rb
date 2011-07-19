class TodoList < ActiveRecord::Base

  belongs_to :user
  has_many :relationships

  validates :name, :presence => true
  validates :user_id, :presence => true

end
