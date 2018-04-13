module CollaboratorsHelper
  def is_a_current_collaborator?(wiki)
    @current_collaborators = wiki.collaborators.as_json
    @current_collaborators.each do |key|
      collaborator_user_id = key.dig("user_id")
      if current_user.id === collaborator_user_id
        return true
      end
    end
    return false
  end
  def is_the_wiki_owner?(collaborators)
    if @collaborator.wiki.size === 0
      if @collaborator.wiki[0].user_id === current_user.id 
        return true
      end
      return false
    else
      @collaborator.wiki.each do |i| 
        # binding.pry
        if i.user_id === current_user.id
          return true
        end
      end
      return false
    end
  end
  def is_a_collaborator?(collaborators)
    @collaborator.each do |i| 
      if i.user_id === current_user.id
        return true
      end
    end
    return false
  end
end
