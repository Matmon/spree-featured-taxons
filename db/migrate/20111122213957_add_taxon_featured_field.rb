class AddTaxonFeaturedField < ActiveRecord::Migration
  def up
    add_column :spree_taxons, :featured, :boolean, :default => false, :null => false
  end

  def down
    remove_column :spree_taxons, :featured
  end
end
