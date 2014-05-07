module WorldCat
  module Discovery
    class SearchResults < Spira::Base
      
      property :total_results, :predicate => DISCOVERY_TOTAL_RESULTS, :type => XSD.integer
      property :start_index, :predicate => DISCOVERY_START_INDEX, :type => XSD.integer
      property :items_per_page, :predicate => DISCOVERY_ITEMS_PER_PAGE, :type => XSD.integer
      
      def id
        self.subject
      end
      
    end
  end
end