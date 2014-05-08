module WorldCat
  module Discovery
    class Review < Spira::Base
      
      property :body, :predicate => SCHEMA_REVIEW_BODY, :type => XSD.string
      property :type, :predicate => RDF.type, :type => RDF::URI
      
      def id
        self.subject
      end

    end
  end
end