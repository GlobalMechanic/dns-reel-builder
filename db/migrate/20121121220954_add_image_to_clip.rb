class AddImageToClip < ActiveRecord::Migration
  def change
    add_column :clips, :image, :string
    rename_column :clips, :clip_url, :video
  end
end
