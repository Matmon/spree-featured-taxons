module SpreeFeaturedTaxon
  module FeaturedTaxonClassMethods
    def self.extended(base)
      base.send(:initialize_featured_taxon_scope)
    end

    # set base scope for featured taxons.  This method is available in
    # spree controllers
    def featured_taxon_scope(&b)
      @featured_scope = @initial_featured_scope.call
      @featured_scope = @featured_scope.instance_eval &b if block_given?
      @featured_scope
    end

    private
    # initial scope for featured taxons. Pass a block if the default
    # scope of 'featured' is not a desireable default
    def initialize_featured_taxon_scope(&b)
      @initial_featured_scope = proc { Spree::Taxon.featured }
      @initial_featured_scope = b if block_given?
    end
  end

  module FeaturedTaxonHelperMethods
    def self.included(base)
      base.send :helper_method, :featured_taxons
    end

    private
    def featured_taxon_scope
      self.class.featured_taxon_scope
    end

    # current featured scope.  available as helper method in views.
    # can further customize scope through provided block
    def featured_taxons(&b)
      scope = featured_taxon_scope.clone
      scope = scope.instance_eval &b if block_given?
      FeaturedScope.new(scope)
    end
  end
end
