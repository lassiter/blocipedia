class CreateCollaborators < ActiveRecord::Migration[5.1]
  def change
    create_table :collaborators do |t|
      t.integer :wiki_id
      t.integer :user_id
      t.timestamps null: false
    end
    add_index :collaborators, :wiki_id
    add_index :collaborators, :user_id
  end
end
