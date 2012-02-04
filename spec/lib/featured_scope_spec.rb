require 'spec_helper'
require 'forwardable'

class TestScope
  extend Forwardable
  include Enumerable

  def_delegators :@items, :each, :size, :empty?

  def initialize(items=[])
    @items = items
  end

  def limit(number)
    TestScope.new(@items[0...number])
  end
end

describe SpreeFeaturedTaxon::FeaturedScope do
  let(:items) { (1..3).to_a }
  let(:scope) { TestScope.new(items) }
  subject { SpreeFeaturedTaxon::FeaturedScope.new(scope) }

  it "should indicate its size" do
    subject.size.should == 3
  end

  it "should indicate its count" do
    subject.count.should == 3
  end

  describe "when empty" do
    let(:scope) { TestScope.new([]) }
    it("should indicate it's empty") { subject.should be_empty }
  end

  it "should yield each item in the scope" do
    subject.each_with_index do |item, index|
      item.should == items[index]
    end
  end
end

describe "FeaturedScope sampling" do
  let(:items) { (1..100).to_a }
  let(:sample_size) { 25 }
  let(:scope) do
    s = TestScope.new(items)
    s.should_receive(:sample).with(sample_size).at_least(:once).
      and_return(TestScope.new(items.sample(sample_size)))
    s
  end

  subject { SpreeFeaturedTaxon::FeaturedScope.new(scope) }

  it "should be immutable" do
    s = subject.sample(sample_size)
    subject.count.should_not == s.count
  end

  it "should sample upto the given size" do
    subject.sample(sample_size).count.should == sample_size
  end

  it "should sample items in random order" do
    randomized = subject.sample(sample_size)
    randomized.to_a.should_not == randomized.sort
  end

  it "should provide sample from within the scope" do
    subject.sample(sample_size).each do |item|
      scope.should include(item)
    end
  end
end
