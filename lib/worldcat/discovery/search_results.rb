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

module WorldCat
  module Discovery
    
    # == Properties mapped from RDF data
    #
    # RDF properties are mapped via an ORM style mapping.
    # 
    # [total_results] RDF predicate: http://worldcat.org/searcho/totalResults; returns: Integer
    # [start_index] RDF predicate: http://worldcat.org/searcho/startIndex; returns: Integer
    # [items_per_page] RDF predicate: http://worldcat.org/searcho/itemsPerPage; returns: Integer

    class SearchResults < Spira::Base
      
      property :total_results, :predicate => DISCOVERY_TOTAL_RESULTS, :type => XSD.integer
      property :start_index, :predicate => DISCOVERY_START_INDEX, :type => XSD.integer
      property :items_per_page, :predicate => DISCOVERY_ITEMS_PER_PAGE, :type => XSD.integer
      property :facet_list, :predicate => DISCOVERY_FACET_LIST, :type => 'FacetList'
      has_many :items, :predicate => SCHEMA_SIGNIFICANT_LINK, :type => 'GenericResource'
      
      # call-seq:
      #   id() => RDF::URI
      # 
      # Will return the RDF::URI object that serves as the RDF subject of the current SearchResults
      def id
        self.subject
      end
      
    end
  end
end