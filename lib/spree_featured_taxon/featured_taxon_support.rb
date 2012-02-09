module SpreeFeaturedTaxon
  module FeaturedTaxonClassMethods
    def setup_featured_taxons(&b)
      initialize_featured_taxon_scope &b
      class_eval do
        include FeaturedTaxonHelperMethods
      end
    end

    # set base scope for featured taxons.  This method is available in
    # spree controllers as a class method
    def featured_taxon_scope(&b)
      if block_given?
        tmp ||= class_taxon_scope.call
        @featured_taxon_scope = proc { tmp.instance_eval(&b) }
      end
      class_taxon_scope
    end

    private
    def class_taxon_scope
      @featured_taxon_scope ||= class_variable_get(:@@initial_taxon_scope)
    end

    # initial scope for featured taxons. Pass a block if the default
    # scope of 'featured' is not a desireable default
    def initialize_featured_taxon_scope(&b)
      fail "Featured taxon setup requires an initial scope as block" unless block_given?
      class_variable_set(:@@initial_taxon_scope, b)
    end
  end

  module FeaturedTaxonHelperMethods
    def self.included(base)
      base.send :helper_method, :featured_taxons
    end

    private
    def featured_taxon_scope
      self.class.featured_taxon_scope.call
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
