module WorldCat
  module Discovery
    class SearchResults < Spira::Base
      
      def id
        self.subject
      end
      
    end
  end
end