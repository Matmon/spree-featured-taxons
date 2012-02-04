require 'spree_featured_taxon/featured_taxon_support'

Spree::BaseController.class_eval do
  extend  SpreeFeaturedTaxon::FeaturedTaxonClassMethods
  include SpreeFeaturedTaxon::FeaturedTaxonHelperMethods
end
