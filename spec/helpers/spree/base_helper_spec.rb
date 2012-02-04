require 'spec_helper'
include Spree
include Spree::BaseHelper

describe "Spree::BaseHelper#featured_taxon_list" do
  let(:taxons) do
    [ mock_model(Taxon, :name => 'one', :permalink =>'one'),
      mock_model(Taxon, :name => 'two', :permalink => 'two') ]
  end

  it "should return empty string if taxons are nil" do
    featured_taxon_list(nil).should be_empty
  end

  it "should return empty string if there are no taxons" do
    featured_taxon_list([]).should be_empty
  end

  it "should give a list item per taxon" do
    featured_taxon_list(taxons).
      should have_selector("li", :count => taxons.size)
  end

  describe "defaults" do
    it "should provide a default list id of 'featured-taxons'" do
      featured_taxon_list(taxons).should have_selector('ul#featured-taxons')
    end

    it "should provide a default list class of 'taxons-list'" do
      featured_taxon_list(taxons).should have_selector("ul.taxons-list")
    end

    it "should not give a current class for list items" do
      featured_taxon_list(taxons).should_not have_selector("li.current")
    end

    it "should link to taxons" do
      list = featured_taxon_list(taxons)
      taxons.each do |t|
        list.should have_selector("a[href='/t/#{t.permalink}']")
      end
    end
  end

  describe "with given options" do
    it "should accept an optional list id" do
      featured_taxon_list(taxons, :id => 'test').
        should have_selector("ul#test")
    end

    it "should accept and option list class" do
      featured_taxon_list(taxons, :class => 'test').
        should have_selector("ul.test")
    end

    it "should accept an optional current taxon" do
      current = taxons.first
      current.should_receive(:self_and_ancestors).and_return([current])
      featured_taxon_list(taxons, :current => current).
        should have_selector("li.current")
    end
  end

  describe "when customizing item renderer" do
    it "should yield to given block for taxon rendering inside of li" do
      list = featured_taxon_list(taxons) { |t| "Hello, #{t.name}" }
      taxons.each do |t|
        list.should have_selector("li", :text => "Hello, #{t.name}")
      end
    end
  end
end
