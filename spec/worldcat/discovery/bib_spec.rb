require_relative '../../spec_helper'

describe WorldCat::Discovery::Bib do
  context "when constructing a key" do
    before(:all) do
      @bib = WorldCat::Discovery::Bib.new
    end
    
    it "should produce have the right class" do 
      @bib.class.should == WorldCat::Discovery::Bib
    end
  end
end