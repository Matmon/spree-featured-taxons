module SpreeFeaturedTaxon
  class FeaturedScope
    include Enumerable

    delegate :size, :each, :to => :sampled_scope
    attr_reader :sample_size

    def initialize(scope, sample_size=nil)
      @scope = scope
      @sample_size = sample_size
    end

    def scope
      @scope.clone
    end

    def sample(size)
      FeaturedScope.new(@scope, size)
    end

    def ==(other)
      @scope == other.scope && @sample_size == other.sample_size
    rescue NoMethodError
      false
    end

    private
    def sampled_scope
      @sample_size.to_i > 0 ? @scope.sample(sample_size) : @scope
    end
  end
end
