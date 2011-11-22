class AddTaxonFeaturedField < ActiveRecord::Migration
  def up
  	add_column :taxons, :featured, :boolean, :default => false, :null => false
  end

  def down
  	remove_column :taxons, :featured
  end
end
