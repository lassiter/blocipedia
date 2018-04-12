module CollaboratorsHelper
  def is_a_current_collaborator(wiki)
    @current_collaborators = wiki.collaborators.as_json
    @current_collaborators.each do |key|
      collaborator_user_id = key.dig("user_id")
      break true if current_user.id == collaborator_user_id
    end
  end
end
