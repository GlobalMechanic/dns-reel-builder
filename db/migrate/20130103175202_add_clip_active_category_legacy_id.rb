class AddClipActiveCategoryLegacyId < ActiveRecord::Migration
  def change
    add_column :clips, :active, :boolean
    add_column :clips, :category, :string
    add_column :clips, :legacy_id, :integer
  end
end
