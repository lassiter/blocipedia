class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  has_many :wikis
  attr_accessible :role

  USER_ROLES = {
    :member => 0,
    :premium => 1,
    :admin => 2
  }
  def set_as_admin 
    self.role = USER_ROLES[:admin]
  end

  def set_as_premium 
    self.role = USER_ROLES[:premium]
  end

  def set_as_member 
    self.role = USER_ROLES[:member]
  end
end
