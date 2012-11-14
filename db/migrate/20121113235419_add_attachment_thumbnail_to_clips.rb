class AddAttachmentThumbnailToClips < ActiveRecord::Migration
  def self.up
    change_table :clips do |t|
      t.has_attached_file :thumbnail
    end
  end

  def self.down
    drop_attached_file :clips, :thumbnail
  end
end
