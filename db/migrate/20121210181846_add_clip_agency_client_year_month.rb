class AddClipAgencyClientYearMonth < ActiveRecord::Migration
  def change
    add_column :clips, :agency, :string
    add_column :clips, :client, :string
    add_column :clips, :year, :string
    add_column :clips, :month, :string
  end
end
