class ReelClipsFixPrimaryKey < ActiveRecord::Migration
  # Start over...
 def up
    drop_table :reel_clips
    create_table :reel_clips do |t|
      t.string :reel_id
      t.integer :clip_id
      t.integer :order

      t.timestamps
    end
  end
  def down
    create_table "reel_clips", :id => false, :force => true do |t|
      t.integer  "id"
      t.integer  "clip_id"
      t.integer  "order"
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
      t.string   "reel_id"
    end
  end
end
