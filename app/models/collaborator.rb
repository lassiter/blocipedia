class Collaborator < ApplicationRecord
belongs_to :wiki
belongs_to :user

   def self.wiki
     Wiki.where( id: pluck(:wiki_id) )
   end
 
   def self.user
     User.where( id: pluck(:user_id) )
   end
 
   def wiki
     Wiki.find(wiki_id)
   end
 
   def user
     User.find(user_id)
   end

end
