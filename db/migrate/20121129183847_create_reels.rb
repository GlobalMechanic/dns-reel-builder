class CreateReels < ActiveRecord::Migration
  def change
    create_table :reels do |t|
      t.string :title
      t.references :user

      t.timestamps
    end
    add_index :reels, :user_id
  end
end
