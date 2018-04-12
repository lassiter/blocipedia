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
end
