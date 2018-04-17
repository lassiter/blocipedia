module CollaboratorsHelper
# loops through active record array of collaborators
  def are_a_current_collaborator?(collaborator)
    collaborator = collaborator.as_json
    collaborator.each do |c|
      collaborator_user_id = c.dig("user_id")
      if current_user.id === collaborator_user_id
        return true
      end
    end
    return false
  end
end
