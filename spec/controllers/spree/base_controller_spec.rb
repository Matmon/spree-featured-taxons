require 'spec_helper'

describe Spree::BaseController do
  before { Taxon.should_receive(:featured).and_return(featured) }
  let(:featured) do
    [
      mock_model(Taxon, :name => 'test'),
      mock_model(Taxon, :name => 'test2')
    ]
  end
  let(:featured_scope) { SpreeFeaturedTaxon::FeaturedScope.new(featured) }

  describe "when featured scope is not specified" do
    it "should default to all featured taxons" do
      subject.featured_taxons.should == featured_scope
    end
  end

  describe "when featured scope is customized" do
    let(:conditions) { "updated_at <= now()" }
    let(:featured) do
      taxons = [
        mock_model(Taxon, :name => 'test'),
        mock_model(Taxon, :name => 'test2')
      ]
      taxons.should_receive(:where).with("test conditions").
        and_return(taxons[0...1])
      taxons
    end

    it "should yield the current scope to the block for customization" do
      subject.featured_taxon_scope { where("test conditions") }
      subject.featured_taxons.size.should == 1
    end

    it "should allow for featured scope customization per call" do
      subject.featured_taxons { where("test conditions") }.size.should == 1
      subject.featured_taxons.should == featured_scope
    end
  end
end
