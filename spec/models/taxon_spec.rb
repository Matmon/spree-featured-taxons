require 'spec_helper'

describe "Taxon#featured" do
  subject { Taxon }
  let(:featured)     { Factory(:taxon, :featured => true)  }
  let(:not_featured) { Factory(:taxon, :featured => false) }
  it "should include featured taxons" do
    subject.featured.should include(featured)
  end

  it "should not include taxons that are not featured" do
    subject.featured.should_not include(not_featured)
  end

  it "should count featured taxons" do
    subject.featured.size.should == 1
  end
end

describe "Taxon" do
  describe "when featured" do
    subject { Factory.build(:taxon, :featured => true) }
    it "should indicate it is featured" do
      subject.should be_featured
    end
  end

  describe "when not featured" do
    subject { Factory.build(:taxon, :featured => false) }
    it "should not indicate it is featured" do
      subject.should_not be_featured
    end
  end
end
