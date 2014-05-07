require_relative '../../spec_helper'

describe WorldCat::Discovery::Bib do
  context "when loading a resource from the RDF data" do
    before(:all) do
      url = 'https://beta.worldcat.org/discovery/bib/data/30780581'
      stub_request(:get, url).to_return(
          :body => body_content("30780581.rdf"),
          :status => 200)

      wskey = OCLC::Auth::WSKey.new('api-key', 'api-key-secret')
      @bib = WorldCat::Discovery::Bib.find(30780581, wskey)
    end
    
    it "should have the right id" do
      @bib.id.should == "http://www.worldcat.org/oclc/30780581"
    end
    
    it "should have the right name" do
      @bib.name.should == "The Wittgenstein reader"
    end
    
    it "should have the right OCLC number" do
      @bib.oclc_number.should == 30780581
    end
    
    it "should have the right work URI" do
      @bib.work_uri.should == RDF::URI.new('http://worldcat.org/entity/work/id/45185752')
    end

    it "should have the right number of pages" do
      @bib.num_pages.should == "312"
    end
    
    it "should have the right date published" do
      @bib.date_published.should == "1994"
    end
    
    it "should have the right type" do
      @bib.type.should == RDF::URI.new('http://schema.org/Book')
    end
    
  end
end