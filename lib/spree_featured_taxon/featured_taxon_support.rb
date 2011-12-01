module SpreeFeaturedTaxon
  module FeaturedTaxonSupport
    def self.included(base)
      base.send :helper_method, :featured_taxons
    end

    # set base scope for featured taxons.  This method is available in
    # spree controllers
    def featured_taxon_scope(&b)
      @featured_taxon_scope ||= Taxon.featured
      @featured_taxon_scope = yield @featured_taxon_scope if block_given?
      @featured_taxon_scope
    end

    # current featured scope.  available as helper method in views.
    # can further customize scope that is yielded to provided block
    def featured_taxons(&b)
      scope = featured_taxon_scope.clone
      scope = yield scope if block_given?
      FeaturedScope.new(scope)
    end
  end
end
