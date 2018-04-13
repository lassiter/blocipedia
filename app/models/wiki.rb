# Wiki Model
class Wiki < ApplicationRecord
  belongs_to :user
    validates :title, length: { minimum: 1 }, presence: true
    validates :body, length: { minimum: 100 }, presence: true
    validates :user, presence: true
  has_many :collaborators
  has_many :users, through: :collaborators
  

  #  def collaborators
  #   Collaborator.where(wiki_id: id)
  #  end
 
  #  def users
  #    collaborators.users
  #  end

end
