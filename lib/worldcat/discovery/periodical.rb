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
    # [similar_to] RDF predicate: http://schema.org/musicBy; returns: WorldCat::Discovery::Bib object
    
    class Periodical < Bib
      
      property :similar_to, :predicate => SCHEMA_IS_SIMILAR_TO, :type => 'Bib'
      
      # call-seq:
      #   issn() => string
      # 
      # Returns issn from RDF predicate: http://schema.org/issn
      def issn
        is_like = Spira.repository.query(:subject => self.work_uri, :predicate => UMBEL_IS_LIKE).first
        issn = Spira.repository.query(:subject => is_like.object, :predicate => SCHEMA_ISSN).first
        issn
      end
      
    end
  end
end