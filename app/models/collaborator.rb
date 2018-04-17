class Collaborator < ApplicationRecord
belongs_to :wiki
belongs_to :user

  #  def self.wiki
  #    Wiki.where( id: pluck(:wiki_id) )
  #  end
end
