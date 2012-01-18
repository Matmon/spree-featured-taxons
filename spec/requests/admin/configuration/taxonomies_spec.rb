require "spec_helper"

describe "Taxonomies" do
  let(:taxon) { @taxon }

  describe "featuring a taxon" do
    before do
      @taxon = Factory :taxon, :name => 'test'
    end

    it "should allow an admin to check 'featured' when editing a taxon" do
      visit spree.edit_admin_taxonomy_taxon_path(taxon.taxonomy, taxon)
      find_by_id("taxon_featured").should_not be_checked
      check "Featured"
      click_button "Update"
      page.should have_content("Taxon \"test\" has been successfully updated!")
      taxon.reload.should be_featured
    end
  end

  describe "unfeaturing a taxon" do
    before do
      @taxon = Factory :taxon, :name => 'test', :featured => true
    end

    it "should allow admin to uncheck 'featured' when editing a taxon" do
      visit spree.edit_admin_taxonomy_taxon_path(taxon.taxonomy, taxon)
      find_by_id("taxon_featured").should be_checked
      uncheck "Featured"
      click_button "Update"
      page.should have_content("Taxon \"test\" has been successfully updated!")
      taxon.reload.should_not be_featured
    end
  end
end
