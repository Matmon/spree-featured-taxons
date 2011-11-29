module SpreeFeaturedTaxon
  class FeaturedScope
    include Enumerable
    delegate :size, :each, :to => :sampled_scope
    attr_reader :sample_size

    def initialize(scope, sample_size=nil)
      @scope = scope
      @sample_size = sample_size
    end

    def limit(number)
      FeaturedScope.new(@scope.limit(number), sample_size)
    end

    def sample(size)
      @sample_size = size
      self
    end

    private
    def sampled_scope
      @sample_size.to_i > 0 ? @scope.sample(sample_size) : @scope
    end
  end
end
