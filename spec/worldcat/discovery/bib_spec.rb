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
    
    it "should have the right name" do
      @bib.name.should == "The Wittgenstein reader"
    end
  end
end