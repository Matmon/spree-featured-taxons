require 'spree_featured_taxon/featured_taxon_support'
include SpreeFeaturedTaxon

Spree::BaseController.class_eval do
  extend FeaturedTaxonClassMethods
  setup_featured_taxons do
    Spree::Taxon.featured
  end
end
