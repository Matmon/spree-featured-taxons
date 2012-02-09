require 'spec_helper'

describe "Taxon featuring" do
  it "should display a heading in the sidebar" do
    visit spree.root_path
    within("#sidebar h6.featured-taxon-root") do
      page.text.should match(/featured/i)
    end
  end

  describe "when there are taxons selected for featuring" do
    before :each do
      Factory(:taxon, :name => 'test featured', :featured => true)
      Factory(:taxon, :name => 'another featured', :featured => true)
    end

    it "should display taxons in sidebar by default" do
      visit spree.root_path
      within("#sidebar #featured-taxons") do
        page.should have_selector("#featured-taxons-list > li", :count => 2)
      end
    end

    it "should provide link to featured taxons" do
      visit spree.root_path
      find("#featured-taxons-list").should have_link 'test featured'
    end

    it "should link to featured taxon page" do
      visit spree.root_path
      within("#featured-taxons-list") do
        click_link 'test featured'
        page.should have_content("test featured")
      end
    end
  end

  describe "when there are no taxons selected for featuring" do
    it "should not display the featured taxon list" do
      visit spree.root_path
      within("#sidebar #featured-taxons") do
        page.should_not have_selector("#featured-taxons-list")
      end
    end
  end
end
