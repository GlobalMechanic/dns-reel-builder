class ClipsRenameNameToDirector < ActiveRecord::Migration
  def change
    rename_column :clips, :name, :director 
  end
end
