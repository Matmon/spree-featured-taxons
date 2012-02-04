require 'spec_helper.rb'

class TestController
  # helper method is required for mixin containing helper methods
  # so we make method name passed to helper method public for tests :p
  def self.helper_method(name)
    send(:public, name)
  end

  extend SpreeFeaturedTaxon::FeaturedTaxonClassMethods
  include SpreeFeaturedTaxon::FeaturedTaxonHelperMethods
end

describe "FeaturedTaxonClassMethods" do
  subject { TestController }
  let(:featured) { ['one', 'two', 'three' ] }

  describe "with default featured scope " do
    before do
      Spree::Taxon.should_receive(:featured).at_least(:once).
        and_return(featured)
    end

    it "should provide a list of featured items by default" do
      subject.featured_taxon_scope.should == featured
    end

    it "should permit changing scope" do
      subject.featured_taxon_scope do
        self << 'four'
      end
      subject.featured_taxon_scope.should == featured << 'four'
    end
  end

  describe "when initial scope is declared" do
    subject { TestClass }
    before do
      TestClass = Class.new(TestController)
      TestClass.class_eval do
        initialize_featured_taxon_scope do
          ['one', 'two']
        end
      end
    end

    it "should use provided scope as default scope" do
      subject.featured_taxon_scope.should == ['one', 'two']
    end
  end
end

describe "FeaturedTaxonHelperMethods" do
  subject { TestController.new }
  let(:featured) { ['one', 'two'] }
  before { Spree::Taxon.should_receive(:featured).and_return(featured) }

  it "should give featured taxons in featured scope" do
    taxons = subject.featured_taxons
    taxons.size.should == 2
    taxons.first.should == 'one'
  end

  it "should allow customization of the scope" do
    taxons = subject.featured_taxons { shift; self }
    taxons.size.should == 1
    taxons.first.should == 'two'
  end
end
