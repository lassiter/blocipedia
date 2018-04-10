class User < ApplicationRecord
  enum role: [:member, :premium, :admin]
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  has_many :wikis
  has_many :collaborators
  


   def collaborators
     Collaborators.where(collaborator_id: id)
   end
 
   def wikis
    collaborators.wikis
   end


end
