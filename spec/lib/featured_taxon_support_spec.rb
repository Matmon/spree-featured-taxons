require 'spec_helper.rb'

class StubController
  # helper method is required for mixin containing helper methods
  # so we make method name passed to helper method public for tests :p
  def self.helper_method(name)
    send(:public, name)
  end
end
class SubController < StubController; end

StubController.extend SpreeFeaturedTaxon::FeaturedTaxonClassMethods
StubController.setup_featured_taxons do
  Spree::Taxon.featured
end

describe "FeaturedTaxonClassMethods" do
  subject { Class.new(StubController) }
  let(:featured) { ['one', 'two', 'three' ] }

  describe "with default featured scope " do
    before do
      Spree::Taxon.should_receive(:featured).at_least(:once).
        and_return(featured)
    end

    it "should provide a list of featured items by default" do
      subject.featured_taxon_scope.call.should == featured
    end

    it "should permit changing scope" do
      subject.featured_taxon_scope do
        push('four')
      end
      subject.featured_taxon_scope.call.
        should == ['one', 'two', 'three', 'four']
    end
  end

  describe "when initial scope is declared" do
    subject { SubClass }
    before do
      SubClass = Class.new(SubController)
      SubClass.class_eval do
        extend SpreeFeaturedTaxon::FeaturedTaxonClassMethods
        setup_featured_taxons do
          ['one', 'two']
        end
      end
    end

    it "should use provided scope as default scope" do
      subject.featured_taxon_scope.call.should == ['one', 'two']
    end
  end
end

describe "FeaturedTaxonHelperMethods" do
  subject { Class.new(StubController).new }
  let(:featured) { ['one', 'two'] }

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
