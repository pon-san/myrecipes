class RenameColumnChefIdToUserIdInComments < ActiveRecord::Migration[5.2]
  def change
    rename_column :comments, :chef_id, :user_id
  end
end
