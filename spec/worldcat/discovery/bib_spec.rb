# Copyright 2014 OCLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require_relative '../../spec_helper'

describe WorldCat::Discovery::Bib do
  
  # This context must always run first. Once the configuration singleton is run in the next context,
  # these tests cannot pass as the error conditions will never be caught.
  context "when trying to find or search for Bib objects before configuring the API key" do
    it "should raise an error when calling the find() method on the Bib class" do
      url = 'https://beta.worldcat.org/discovery/bib/data/30780581'
      stub_request(:get, url).to_return(:body => body_content("30780581.rdf"), :status => 200)
      lambda { bib = WorldCat::Discovery::Bib.find(30780581) }.should raise_error(WorldCat::Discovery::ConfigurationException, 
          'Cannot find/search Bib resources unless an API key is configured. Call WorldCat::Discovery.configure(wskey) with an OCLC::Auth::WSKey'
        )
    end
    
    it "should raise an error when calling the find() method on the Bib class" do
      url = 'https://beta.worldcat.org/discovery/bib/search?q=wittgenstein+reader'
      stub_request(:get, url).to_return(:body => body_content("bib_search.rdf"), :status => 200)
      lambda { WorldCat::Discovery::Bib.search(:q => 'wittgenstein reader') }.should raise_error(WorldCat::Discovery::ConfigurationException, 
          'Cannot find/search Bib resources unless an API key is configured. Call WorldCat::Discovery.configure(wskey) with an OCLC::Auth::WSKey'
        )
    end
  end
  
  context "when loading bibliographic data" do
    before(:all) do
      wskey = OCLC::Auth::WSKey.new('api-key', 'api-key-secret', :services => ['WorldCatDiscoveryAPI'])
      WorldCat::Discovery.configure(wskey, 128807, 128807)
      url = 'https://authn.sd00.worldcat.org/oauth2/accessToken?authenticatingInstitutionId=128807&contextInstitutionId=128807&grant_type=client_credentials&scope=WorldCatDiscoveryAPI'
      stub_request(:post, url).to_return(:body => body_content("token.json"), :status => 200)
    end

    context "from a single resource from the RDF data for The Wittgenstein Reader" do
      before(:all) do
        url = 'https://beta.worldcat.org/discovery/bib/data/30780581'
        stub_request(:get, url).to_return(:body => body_content("30780581.rdf"), :status => 200)
        @bib = WorldCat::Discovery::Bib.find(30780581)
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

     #deprecated property
     #it "should have the right number of pages" do
     #   @bib.num_pages.should == "312"
     #end

      it "should have the right date published" do
        @bib.date_published.should == "1994"
      end

      it "should have the right type" do
        @bib.type.should == RDF::URI.new('http://schema.org/Book')
      end

      #deprecated property
      #it "should have the right OWL same as property" do
      #  @bib.same_as.should == RDF::URI.new("info:oclcnum/30780581")
      #end

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
        subject_ids.should include(RDF::URI('http://experiment.worldcat.org/entity/work/data/45185752#Topic/filosofia_contemporanea_alemanha'))
        subject_ids.should include(RDF::URI('http://experiment.worldcat.org/entity/work/data/45185752#Topic/wissenschaftstheorie'))
        subject_ids.should include(RDF::URI('http://experiment.worldcat.org/entity/work/data/45185752#Topic/analytische_philosophie'))

        subject_names = subjects.map {|subject| subject.name}
        subject_names.should include("Filosofia contemporânea--Alemanha.")
        subject_names.should include("Wissenschaftstheorie.")
        subject_names.should include("Analytische Philosophie.")
        subject_names.should include("Philosophy.")
      end

      it "should have the right work examples" do
        work_examples = @bib.work_examples
        work_examples.each {|product_model| product_model.class.should == WorldCat::Discovery::ProductModel}

        work_example_uris = work_examples.map {|product_model| product_model.id}
        work_example_uris.should include(RDF::URI('http://worldcat.org/isbn/9780631193616'))
        work_example_uris.should include(RDF::URI('http://worldcat.org/isbn/9780631193623'))
      end

      it "should have the right places of publication" do
        places_of_publication = @bib.places_of_publication
        places_of_publication.size.should == 3

        oxford = places_of_publication.reduce(nil) do |p, place| 
          p = place if place.id == RDF::URI('http://experiment.worldcat.org/entity/work/data/45185752#Place/oxford_uk')
          p
        end
        oxford.class.should == WorldCat::Discovery::Place
        oxford.type.should == 'http://schema.org/Place'
        oxford.name.should == 'Oxford, UK'

        cambridge = places_of_publication.reduce(nil) do |p, place|
          if place.id == RDF::URI('http://experiment.worldcat.org/entity/work/data/45185752#Place/cambridge_mass_usa')
            p = place 
          end
          p
        end
        cambridge.class.should == WorldCat::Discovery::Place
        cambridge.type.should == 'http://schema.org/Place'
        cambridge.name.should == 'Cambridge, Mass., USA'

        england = places_of_publication.reduce(nil) {|p, place| p = place if place.id == RDF::URI('http://id.loc.gov/vocabulary/countries/enk'); p}
        england.class.should == WorldCat::Discovery::Place
        england.type.should == 'http://schema.org/Place'      
      end

      it "should have the right descriptions" do
        descriptions = @bib.descriptions
        descriptions.size.should == 2

        File.open("#{File.expand_path(File.dirname(__FILE__))}/../../support/text/30780581_descriptions.txt").each do |line|
          descriptions.should include(line.chomp)
        end
      end

      it "should have the right isbns" do
        @bib.isbns.sort.should == ["0631193618", "0631193626", "9780631193616", "9780631193623"]
      end
      
      it "should have the right data_sets" do
        @bib.data_sets.should include(RDF::URI("http://purl.oclc.org/dataset/WorldCat"))
      end

    end
      
    context "from a single resource from the RDF data for 7977212" do
      before(:all) do
        url = 'https://beta.worldcat.org/discovery/bib/data/7977212'
        stub_request(:get, url).to_return(:body => body_content("7977212.rdf"), :status => 200)
        @bib = WorldCat::Discovery::Bib.find(7977212)
      end  
          
      it "should have the right genres" do
        @bib.genres.sort.should == ["Poetry"]
      end
        
      it "should return the right copyright_year" do
        @bib.copyright_year.should == "1939"
      end
      
      it "should have the right date_modified" do
        @bib.described_by.date_modified.should == "2015-05-28"
      end
      
      it "should have the right audience" do
        @bib.audience.should be_nil
      end
        
    end
    
    context "from a single resource from the RDF data for 15317067" do
      before(:all) do
        url = 'https://beta.worldcat.org/discovery/bib/data/15317067'
        stub_request(:get, url).to_return(:body => body_content("15317067.rdf"), :status => 200)
        @bib = WorldCat::Discovery::Bib.find(15317067)
      end 
            
      it "should have the right audience" do
        @bib.audience.should == "Juvenile"
      end 
      
      it "should have the right illustrators" do
        @bib.illustrators.size.should == 1
        illustrator = @bib.illustrators.first
        illustrator.class.should == WorldCat::Discovery::Person
        illustrator.name.should == "Bernadette Watts"
      end
      
      it "should return the right book_format" do
        @bib.book_format.should == RDF::URI("http://bibliograph.net/PrintBook")
      end     
    end
      
    context "from a single resource from the RDF data for 41266045" do
      before(:all) do
        url = 'https://beta.worldcat.org/discovery/bib/data/41266045'
        stub_request(:get, url).to_return(:body => body_content("41266045.rdf"), :status => 200)
        @bib = WorldCat::Discovery::Bib.find(41266045)
      end 
            
      it "should have the right awards" do
       @bib.awards.should include("ALA Notable Children's Book, 2000.")
       @bib.awards.should include("Whitbread Children's Book of the Year, 1999.")
      end
      
      it "should have the right content_rating" do
        @bib.content_rating.should == "Middle School."   
      end
    end

    context "from a single resource from the RDF data for 1004282" do
      before(:all) do
        url = 'https://beta.worldcat.org/discovery/bib/data/1004282'
        stub_request(:get, url).to_return(:body => body_content("1004282.rdf"), :status => 200)
        @bib = WorldCat::Discovery::Bib.find(1004282)
      end  
          
      it "should return the right editors" do
        @bib.editors.size.should == 1
        editor = @bib.editors.first
        editor.class.should == WorldCat::Discovery::Person
        editor.name.should == "Dunn, Jacob Piatt, 1855-1924."
      end
    end
      

    context "from a single resource from the RDF data for The Big Typescript" do
      before(:all) do
        url = 'https://beta.worldcat.org/discovery/bib/data/57422379'
        stub_request(:get, url).to_return(:body => body_content("57422379.rdf"), :status => 200)
        @bib = WorldCat::Discovery::Bib.find(57422379)
      end

      it "should have the right book edition" do
        @bib.book_edition.should == "German-English scholar's ed."
      end

      it "should have the right reviews" do
        reviews = @bib.reviews
        reviews.size.should == 1

        review_bodies = reviews.map {|review| review.body}
        File.open("#{File.expand_path(File.dirname(__FILE__))}/../../support/text/57422379_reviews.txt").each do |line|
          review_bodies.should include(line.chomp)
        end
        reviews.first.id.should == RDF::URI("http://www.worldcat.org/title/-/oclc/57422379#Review/-1284714232")
      end
    end

    context "from data for bib resources that don't have personal authors" do
      it "should handle books with no author" do
        url = 'https://beta.worldcat.org/discovery/bib/data/45621749'
        stub_request(:get, url).to_return(:body => body_content("45621749.rdf"), :status => 200)
        wskey = OCLC::Auth::WSKey.new('api-key', 'api-key-secret', :services => ['WorldCatDiscoveryAPI'])
        bib = WorldCat::Discovery::Bib.find(45621749)

        bib.author.should == nil
      end
      
      it "should handle authors that are organizations" do
        url = 'https://beta.worldcat.org/discovery/bib/data/233192257'
        stub_request(:get, url).to_return(:body => body_content("233192257.rdf"), :status => 200)
        # wskey = OCLC::Auth::WSKey.new('api-key', 'api-key-secret')
        bib = WorldCat::Discovery::Bib.find(233192257)

        bib.author.class.should == WorldCat::Discovery::Organization
        bib.author.name.should == "United States. National Park Service."
      end
    end
    
    context "from data that uses the schema:author property" do
      it "should have the correct author data" do
        url = 'https://beta.worldcat.org/discovery/bib/data/30780581'
        stub_request(:get, url).to_return(:body => body_content("30780581-v1.rdf"), :status => 200)
        # wskey = OCLC::Auth::WSKey.new('api-key', 'api-key-secret')
        bib = WorldCat::Discovery::Bib.find(30780581)

        bib.author.class.should == WorldCat::Discovery::Person
        bib.author.name.should == "Wittgenstein, Ludwig, 1889-1951."
      end
    end

    context "from a search for bib resources" do
      context "when retrieving the first page of results" do
        before(:all) do
          url = 'https://beta.worldcat.org/discovery/bib/search?q=wittgenstein+reader&facetFields=creator:10&facetFields=inLanguage:10&dbIds=638'
          stub_request(:get, url).to_return(:body => body_content("bib_search.rdf"), :status => 200)
          @results = WorldCat::Discovery::Bib.search(:q => 'wittgenstein reader', :facetFields => ['creator:10', 'inLanguage:10'])
        end

        it "should return a bib results set" do
          @results.class.should == WorldCat::Discovery::BibSearchResults
        end

        it "should contain the right id" do
          uri = RDF::URI("https://beta.worldcat.org/discovery/bib/search?dbIds=638=creator:10=inLanguage:10=10=wittgenstein reader=relevance=0")
          @results.id.should == uri
        end

        it "should have the right number for total results" do
          @results.total_results.should == 1331
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

        it "should respond to a request for its items as bibs" do
          @results.bibs.size.should == 10
          @results.bibs.each {|item| item.class.should == WorldCat::Discovery::Bib}
        end

        it "should return the bibs in sorted order" do
          0.upto(9) {|i| @results.bibs[i].display_position.should == i+1}
        end

        context "when asking for facets" do
          before(:all) do
            @base_url = 'http://oclc.org/searchRetrieveResponse'
          end

          it "should have the correct number of facets" do
            @results.facets.size.should == 2
          end

          it "should have the correct facet indices" do
            facet_indices = @results.facets.map{|facet| facet.index}
            facet_indices.should include('creator')
            facet_indices.should include('inLanguage')
          end

          it "should have facets with the correct IDs" do
            ids = @results.facets.map{|facet| facet.id.to_s}
            ids.should include("_:A7")
            ids.should include("_:A19")
          end

          it "should have facet values with the correct IDs" do
            value_ids = @results.facets.first.values.map{|value| value.id.to_s}
            ["_:A3", "_:A6", "_:A5", "_:A11", "_:A12", "_:A9", "_:A10", "_:A13", "_:A8", "_:A1"].each do |node_id|
              value_ids.should include(node_id)
            end
          end      

          it "should sort the facet values high to low" do
            # @results.facets.first.values.first.count.should > @results.facets.first.values.last.count
            last_count = nil
            @results.facets.first.values.each do |facet_value|
              if last_count != nil
                facet_value.count.should <= last_count
              end
              last_count = facet_value.count
            end
          end

          it "should have the correct facet value name" do
            author_facet = @results.facets.find {|facet| facet if facet.index == 'creator'}
            author_facet.values.first.name.should.should == 'thomas gary'
          end
        end        
      end
      
      context "when paging for the second list of results" do 
        before(:all) do
          url = 'https://beta.worldcat.org/discovery/bib/search?q=wittgenstein+reader&startIndex=10&dbIds=638'
          stub_request(:get, url).to_return(:body => body_content("bib_search_page_two.rdf"), :status => 200)
          @results = WorldCat::Discovery::Bib.search(:q => 'wittgenstein reader', :startIndex => 10)
        end

        it "should have the right start index" do
          @results.start_index.should == 10
        end
        
      end
    end
  end
  
  context "when sending malformed queries to the API" do
    before(:all) do
      wskey = OCLC::Auth::WSKey.new('api-key', 'api-key-secret', :services => ['WorldCatDiscoveryAPI'])
      WorldCat::Discovery.configure(wskey, 128807, 128807)
      url = 'https://authn.sd00.worldcat.org/oauth2/accessToken?authenticatingInstitutionId=128807&contextInstitutionId=128807&grant_type=client_credentials&scope=WorldCatDiscoveryAPI'
      stub_request(:post, url).to_return(:body => body_content("token.json"), :status => 200)
    end
    
    context "if sending an empty q parameter" do
      before(:all) do
        url = 'https://beta.worldcat.org/discovery/bib/search?q=&dbIds=638'
        stub_request(:get, url).to_return(:body => body_content("error_response_empty_query.rdf"), :status => 400)
        @results = WorldCat::Discovery::Bib.search(:q => '')
      end
      
      it "should return a client request error" do
        @results.class.should == WorldCat::Discovery::ClientRequestError
      end

      it "should contain the right id" do
        @results.subject.should == RDF::Node.new("A0")
      end

      it "should have an error message" do
        @results.error_message.should == 'Invalid q parameter.  Please provide a value for the q parameter which is at least 3 characters in length.'
      end
      
      it "should have an error code" do
        @results.error_code.should == 400
      end
      
      it "should have an error type" do
        @results.error_type.should == 'http'
      end
    end
    
    context "if sending an unknown OCLC Number" do
      before(:all) do
        url = 'https://beta.worldcat.org/discovery/bib/data/999999999999999'
        stub_request(:get, url).to_return(:body => body_content("error_response_not_found.rdf"), :status => 404)
        @results = WorldCat::Discovery::Bib.find(999999999999999)
      end
      
      it "should return a client request error" do
        @results.class.should == WorldCat::Discovery::ClientRequestError
      end

      it "should contain the right id" do
        @results.subject.should == RDF::Node.new("A0")
      end

      it "should have an error message" do
        @results.error_message.should == 'The requested record could not be found.'
      end
      
      it "should have an error code" do
        @results.error_code.should == 404
      end
      
      it "should have an error type" do
        @results.error_type.should == 'http'
      end
    end
    
    context "if sending a query for a database that don't have access to" do
      before(:all) do
        url = 'https://beta.worldcat.org/discovery/bib/search?q=economy&dbIds=635'
        stub_request(:get, url).to_return(:body => body_content("error_response_database_forbidden.rdf"), :status => 403)
        @results = WorldCat::Discovery::Bib.search(:q => 'economy', :dbIds => '635')
      end
      
      it "should return a client request error" do
        @results.class.should == WorldCat::Discovery::ClientRequestError
      end

      it "should contain the right id" do
        @results.subject.should == RDF::Node.new("A0")
      end

      it "should have an error message" do
        @results.error_message.should == 'Your query included one or more databases for which you do not have access rights. [635]'
      end
      
      it "should have an error code" do
        @results.error_code.should == 403
      end
      
      it "should have an error type" do
        @results.error_type.should == 'http'
      end
    end
    
    context "if sending a request that causes a server error" do
      before(:all) do
        url = 'https://beta.worldcat.org/discovery/bib/data/41266045'
        stub_request(:get, url).to_return(:body => body_content("error_response_server_issue.rdf"), :status => 500)
        @results = WorldCat::Discovery::Bib.find(41266045)
      end
      
      it "should return a client request error" do
        @results.class.should == WorldCat::Discovery::ClientRequestError
      end

      it "should contain the right id" do
        @results.subject.should == RDF::Node.new("A0")
      end

      it "should have an error message" do
        @results.error_message.should == 'Internal server error.'
      end
      
      it "should have an error code" do
        @results.error_code.should == 500
      end
      
      it "should have an error type" do
        @results.error_type.should == 'http'
      end
    end    
  end
end