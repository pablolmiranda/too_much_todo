class User < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable

  validates :name, :presence => true
  validates :avatar, :integrity => true,
    :processing => true

  has_many :todo_lists 
  has_many :relationships, :foreign_key => "follower_id", :dependent => :destroy
  has_many :following, :through => :relationships, :source => :followed_list

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :avatar, :avatar_cache, :remove_avatar

  def follow!(todo_list) 
    relationships.create(:followed_list_id => todo_list.id)
  end

  def unfollow!(todo_list)
    following?(todo_list).destroy
  end

  def following?(todo_list)
    relationships.find_by_followed_list_id(todo_list.id) 
  end


end
