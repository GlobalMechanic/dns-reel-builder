class AddReelSlug < ActiveRecord::Migration
  def change
    add_column :reels, :slug, :string
    remove_column :reels, :id
  end
end
