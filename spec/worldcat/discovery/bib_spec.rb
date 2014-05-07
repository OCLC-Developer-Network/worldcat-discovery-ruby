require_relative '../../spec_helper'

describe WorldCat::Discovery::Bib do
  context "when finding a single bib resource from the RDF data" do
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
    
    it "should have the right OWL same as property" do
      @bib.same_as.should == RDF::URI.new("info:oclcnum/30780581")
    end
    
    it "should have the right language" do
      @bib.language.should == "en"
    end
    
    it "should have the right author" do
      @bib.author.class.should == WorldCat::Discovery::Person
      @bib.author.name.should == "Wittgenstein, Ludwig, 1889-1951."
    end
    
    it "should have the right publisher" do
      @bib.publisher.class.should == WorldCat::Discovery::Organization
      @bib.publisher.name.should == "B. Blackwell"
    end
    
    it "should have the right contributors" do
      @bib.contributors.size.should == 1
      contributor = @bib.contributors.first
      contributor.class.should == WorldCat::Discovery::Person
      contributor.name.should == "Kenny, Anthony, 1931-"
    end
    
    it "should have the right subjects" do
      subjects = @bib.subjects
      subjects.each {|subject| subject.class.should == WorldCat::Discovery::Subject}
      
      subject_ids = subjects.map {|subject| subject.id}
      subject_ids.should include(RDF::URI('http://dewey.info/class/192/e20/'))
      subject_ids.should include(RDF::URI('http://id.loc.gov/authorities/classification/B3376'))
      subject_ids.should include(RDF::URI('http://id.worldcat.org/fast/1060777'))
      subject_ids.should include(RDF::Node('A0'))
      subject_ids.should include(RDF::Node('A1'))
      subject_ids.should include(RDF::Node('A4'))
      subject_ids.should include(RDF::Node('A5'))
      
      subject_names = subjects.map {|subject| subject.name}
      subject_names.should include("Filosofia contemporânea--Alemanha.")
      subject_names.should include("Wissenschaftstheorie.")
      subject_names.should include("Analytische Philosophie.")
      subject_names.should include("Philosophy.")
    end
    
    it "should have the right work example URIs" do
      work_example_uris = @bib.work_example_uris
      work_example_uris.should include(RDF::URI('http://www.worldcat.org/isbn/9780631193623'))
      work_example_uris.should include(RDF::URI('http://www.worldcat.org/isbn/9780631193616'))
      work_example_uris.should include(RDF::URI('http://www.worldcat.org/isbn/0631193626'))
      work_example_uris.should include(RDF::URI('http://www.worldcat.org/isbn/0631193618'))
    end
    
    it "should have the right places of publication" do
      places_of_publication = @bib.places_of_publication
      places_of_publication.size.should == 3
      
      oxford = places_of_publication.reduce(nil) {|p, place| p = place if place.id == RDF::Node('A2'); p}
      oxford.class.should == WorldCat::Discovery::Place
      oxford.type.should == 'http://schema.org/Place'
      oxford.name.should == 'Oxford, UK'
      
      oxford = places_of_publication.reduce(nil) {|p, place| p = place if place.id == RDF::Node('A6'); p}
      oxford.class.should == WorldCat::Discovery::Place
      oxford.type.should == 'http://schema.org/Place'
      oxford.name.should == 'Cambridge, Mass., USA'
      
      england = places_of_publication.reduce(nil) {|p, place| p = place if place.id == RDF::URI('http://id.loc.gov/vocabulary/countries/enk'); p}
      england.class.should == WorldCat::Discovery::Place
      england.type.should == 'http://schema.org/Country'      
    end
    
    it "should have the right descriptions" do
      descriptions = @bib.descriptions
      descriptions.size.should == 2
      
      File.open("#{File.expand_path(File.dirname(__FILE__))}/../../support/text/30780581_descriptions.txt").each do |line|
        descriptions.should include(line.chomp)
      end
    end
  end
  
  context "when searching for bib resources" do
    before(:all) do
      url = 'https://beta.worldcat.org/discovery/bib/search?q=wittgenstein+reader&facets=author:10'
      stub_request(:get, url).to_return(
          :body => body_content("bib_search.rdf"),
          :status => 200)

      wskey = OCLC::Auth::WSKey.new('api-key', 'api-key-secret')
      @results = WorldCat::Discovery::Bib.search(wskey, :q => 'wittgenstein reader', :facets => 'author:10')
    end
    
    it "should return a results set" do
      @results.class.should == WorldCat::Discovery::SearchResults
    end
    
    it "should contain the right id" do
      uri = RDF::URI("http://beta.worldcat.org/discovery/bib/search?facets=author:10&itemsPerPage=10&q=wittgenstein reader&startNum=0")
      @results.id.should == uri
    end
    
    it "should have the right number for total results" do
      @results.total_results.should == 1120
    end

    it "should have the right start index" do
      @results.start_index.should == 0
    end

    it "should have the right items per page" do
      @results.items_per_page.should == 10
    end
    
    it "should have the right number of items" do
      @results.items.size.should == 10
    end

    it "should have the right kind of items" do
      @results.items.each {|item| item.class.should == WorldCat::Discovery::GenericResource}
    end
    
    it "should have respond to a request for its items as bibs" do
      @results.bibs.size.should == 10
      @results.bibs.each {|item| item.class.should == WorldCat::Discovery::Bib}
    end
    
    it "should return the bibs in sorted order" do
      0.upto(0) {|i| @results.bibs[i].display_position.should == i+1}
      # 
      # @results.bibs.first.display_position.should == 1
      # @results.bibs.last.display_position.should == 10
    end
  end
end