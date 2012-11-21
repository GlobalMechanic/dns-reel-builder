class AddClipUrlToClip < ActiveRecord::Migration
  def change
    add_column :clips, :clip_url, :string
  end
end
