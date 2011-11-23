require 'spec_helper'

describe Taxon do
	let(:taxon) { Taxon.new(:name => "Featured Test") } 

	context "featured" do 
		it "should indicate if taxon responds to featured" do
			taxon.should respond_to(:featured) 
		end
		it "should not be featured" do
			taxon.should_not be_featured
		end
		it "should be featured" do
			taxon.featured = true
			taxon.should be_featured
		end

		it "should find featured taxons" do
			t1 = Factory(:taxon)
			t2 = Factory(:taxon, :featured => true)
			featured = Taxon.featured
			featured.should include(t2)
			featured.should_not include(t1)
			featured.size.should == 1
		end

	end

end
