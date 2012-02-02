module SpreeFeaturedTaxon
  module FeaturedTaxonSupport
    def self.included(base)
      base.send :helper_method, :featured_taxons
    end

    # set base scope for featured taxons.  This method is available in
    # spree controllers
    def featured_taxon_scope(&b)
      @featured_taxon_scope ||= Spree::Taxon.featured
      if block_given?
        @featured_taxon_scope = @featured_taxon_scope.instance_eval &b
      end
      @featured_taxon_scope
    end

    # current featured scope.  available as helper method in views.
    # can further customize scope that is yielded to provided block
    def featured_taxons(&b)
      scope = featured_taxon_scope.clone
      if block_given?
        scope = scope.instance_eval &b
      end
      FeaturedScope.new scope
    end
  end
end
