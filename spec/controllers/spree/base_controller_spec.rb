require 'spec_helper'

describe Spree::BaseController do
  before { Taxon.should_receive(:featured).and_return(featured) }
  let(:featured_scope) { SpreeFeaturedTaxon::FeaturedScope.new(featured) }
  let(:featured) do
    [ mock_model(Taxon, :name => 'test'), mock_model(Taxon, :name => 'test2') ]
  end

  it "should provide featured taxon scope for views" do
    subject.send(:featured_taxons).should == featured_scope
  end
end
