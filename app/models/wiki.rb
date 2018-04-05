# Wiki Model
class Wiki < ApplicationRecord
  belongs_to :user
    validates :title, length: { minimum: 1 }, presence: true
    validates :body, length: { minimum: 100 }, presence: true
    validates :user, presence: true

end
