class UserRenameCurrentReelId < ActiveRecord::Migration
  def change
    remove_column :users, :current_reel_id
    add_column :users, :current_reel_slug, :string
  end
end
