module WorldCat
  module Discovery
    class Bib < Spira::Base
      
      property :name, :predicate => SCHEMA_NAME, :type => XSD.string
      property :oclc_number, :predicate => OCLC_NUMBER, :type => XSD.integer
      property :work_uri, :predicate => EXAMPLE_OF_WORK, :type => RDF::URI
      property :num_pages, :predicate => NUMBER_OF_PAGES, :type => XSD.string
      property :date_published, :predicate => DATE_PUBLISHED, :type => XSD.string
      property :type, :predicate => RDF.type, :type => RDF::URI
      
      def id
        self.subject
      end
            
      def self.find(oclc_number, wskey)
        
        # Make the HTTP Request for the data
        url = "#{Bib.production_url}/data/#{oclc_number}"
        auth = wskey.hmac_signature('GET', url)
        resource = RestClient::Resource.new url
        response = resource.get(:authorization => auth, :accept => 'application/rdf+xml')

        # Load the data into an in-memory RDF repository, get the GenericResource and its Bib
        Spira.repository = RDF::Repository.new.from_rdfxml(response)
        generic_resource = Spira.repository.query(:predicate => RDF.type, :object => GENERIC_RESOURCE).first
        bib = generic_resource.subject.as(GenericResource).about
        
        bib
      end

      def self.production_url
        "https://beta.worldcat.org/discovery/bib"
      end
      
    end
  end
end