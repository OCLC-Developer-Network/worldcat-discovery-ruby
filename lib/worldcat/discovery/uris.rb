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
    
    RDF_TYPE               = RDF::URI.new('http://www.w3.org/1999/02/22-rdf-syntax-ns#type')
    GENERIC_RESOURCE       = RDF::URI.new('http://www.w3.org/2006/gen/ont#ContentTypeGenericResource')
    SCHEMA_ABOUT           = RDF::URI.new('http://schema.org/about')
    SCHEMA_ALT_NAME        = RDF::URI.new('http://schema.org/alternateName')
    SCHEMA_AUTHOR          = RDF::URI.new('http://schema.org/author')
    SCHEMA_CONTRIBUTOR     = RDF::URI.new('http://schema.org/contributor')
    SCHEMA_CREATOR         = RDF::URI.new('http://schema.org/creator')
    SCHEMA_NAME            = RDF::URI.new('http://schema.org/name')
    SCHEMA_BOOK            = RDF::URI.new('http://schema.org/Book')
    SCHEMA_PERSON          = RDF::URI.new('http://schema.org/Person')
    SCHEMA_ORGANIZATION    = RDF::URI.new('http://schema.org/Organization')
    SCHEMA_INTANGIBLE      = RDF::URI.new('http://schema.org/Intangible')
    SCHEMA_PRODUCT_MODEL   = RDF::URI.new('http://schema.org/ProductModel')
    SCHEMA_WORK_EXAMPLE    = RDF::URI.new('http://schema.org/workExample')
    SCHEMA_ISBN            = RDF::URI.new('http://schema.org/isbn')
    SCHEMA_EXAMPLE_OF_WORK = RDF::URI.new('http://schema.org/exampleOfWork')
    SCHEMA_NUMBER_OF_PAGES = RDF::URI.new('http://schema.org/numberOfPages')
    SCHEMA_DATE_PUBLISHED  = RDF::URI.new('http://schema.org/datePublished')
    SCHEMA_IN_LANGUAGE     = RDF::URI.new('http://schema.org/inLanguage')
    SCHEMA_PUBLISHER       = RDF::URI.new('http://schema.org/publisher')
    SCHEMA_DESCRIPTION     = RDF::URI.new('http://schema.org/description')
    SCHEMA_REVIEW          = RDF::URI.new('http://schema.org/reviews')
    SCHEMA_REVIEW_BODY     = RDF::URI.new('http://schema.org/reviewBody')
    SCHEMA_SEARCH_RES_PAGE = RDF::URI.new('http://schema.org/SearchResultsPage')
    SCHEMA_BOOK_EDITION    = RDF::URI.new('http://schema.org/bookEdition')
    SCHEMA_URL             = RDF::URI.new('http://schema.org/url')
    SCHEMA_ITEM_OFFERED    = RDF::URI.new('http://schema.org/itemOffered')
    SCHEMA_SOME_PRODUCTS   = RDF::URI.new('http://schema.org/SomeProducts')
    SCHEMA_LIBRARY         = RDF::URI.new('http://schema.org/Library')
    SCHEMA_MODEL           = RDF::URI.new('http://schema.org/model')
    SCHEMA_IS_PART_OF      = RDF::URI.new('http://schema.org/isPartOf')
    SCHEMA_GIVEN_NAME      = RDF::URI.new('http://schema.org/givenName')
    SCHEMA_FAMILY_NAME     = RDF::URI.new('http://schema.org/familyName')
    SCHEMA_BIRTH_DATE      = RDF::URI.new('http://schema.org/birthDate')
    SCHEMA_DEATH_DATE      = RDF::URI.new('http://schema.org/deathDate')
    SCHEMA_SAME_AS         = RDF::URI.new('http://schema.org/sameAs')
    DCTERMS_COLLECTION     = RDF::URI.new('http://purl.org/dc/terms/Collection')
    LIB_OCLC_NUMBER        = RDF::URI.new('http://purl.org/library/oclcnum')
    LIB_OCLC_SYMBOL        = RDF::URI.new('http://purl.org/library/oclcSymbol')
    LIB_MANAGES            = RDF::URI.new('http://purl.org/library/manages')
    WCR_MANAGED_BY         = RDF::URI.new('http://purl.org/oclc/ontology/wcir/managedBy')
    LIB_PLACE_OF_PUB       = RDF::URI.new('http://purl.org/library/placeOfPublication')
    DISCOVERY_TOTAL_RESULTS  = RDF::URI.new('http://worldcat.org/vocab/discovery/totalResults')
    DISCOVERY_ITEMS_PER_PAGE = RDF::URI.new('http://worldcat.org/vocab/discovery/itemsPerPage')
    DISCOVERY_START_INDEX    = RDF::URI.new('http://worldcat.org/vocab/discovery/startIndex')
    DISCOVERY_FACET          = RDF::URI.new('http://worldcat.org/vocab/discovery/facet')
    DISCOVERY_FACET_INDEX    = RDF::URI.new('http://worldcat.org/vocab/discovery/facetIndex')
    DISCOVERY_FACET_COUNT    = RDF::URI.new('http://worldcat.org/vocab/discovery/count')
    DISCOVERY_FACET_VALUE    = RDF::URI.new('http://worldcat.org/vocab/discovery/facetValue')
    DISCOVERY_SEARCH_RESULTS = RDF::URI.new('http://worldcat.org/vocab/discovery/SearchResults')
    DISCOVERY_DB_ID          = RDF::URI.new('http://worldcat.org/vocab/discovery/dbId')
    DISCOVERY_REQUIRES_AUTHN = RDF::URI.new('http://worldcat.org/vocab/discovery/requiresAuthentication')
    DISCOVERY_HAS_PART       = RDF::URI.new('http://worldcat.org/vocab/discovery/hasPart')
    DISCOVERY_ERROR_CODE     = RDF::URI.new('http://worldcat.org/vocab/discovery/errorCode')
    DISCOVERY_ERROR_MESSAGE  = RDF::URI.new('http://worldcat.org/vocab/discovery/errorMessage')
    DISCOVERY_ERROR_TYPE     = RDF::URI.new('http://worldcat.org/vocab/discovery/errorType')
    CLIENT_REQUEST_ERROR     = RDF::URI.new('http://worldcat.org/xmlschemas/response/ClientRequestError')
    GOOD_RELATIONS_POSITION  = RDF::URI.new('http://purl.org/goodrelations/v1#displayPosition')
    DCMITYPE_DATASET         = RDF::URI.new('http://purl.org/dc/dcmitype/Dataset')
    SCHEMA_MOVIE             = RDF::URI.new('http://schema.org/Movie')
    SCHEMA_ACTOR             = RDF::URI.new('http://schema.org/actor')
    SCHEMA_DIRECTOR          = RDF::URI.new('http://schema.org/director')
    SCHEMA_PRODUCER          = RDF::URI.new('http://schema.org/producer')
    SCHEMA_MUSICBY           = RDF::URI.new('http://schema.org/musicBy')
    SCHEMA_PRODUCTIONCOMPANY = RDF::URI.new('http://schema.org/productionCompany')
    SCHEMA_MUSIC_ALBUM       = RDF::URI.new('http://schema.org/MusicAlbum')
    SCHEMA_BY_ARTIST         = RDF::URI.new('http://schema.org/byArtist')
    SCHEMA_PERFORMER         = RDF::URI.new('http://schema.org/performer')
    SCHEMA_HAS_PART          = RDF::URI.new('http://schema.org/hasPart')
    RDF_SEE_ALSO             = RDF::URI.new('http://www.w3.org/2000/01/rdf-schema#seeAlso')
    RDFS_LABEL                = RDF::URI.new('http://www.w3.org/2000/01/rdf-schema#label')
    SCHEMA_ARTICLE           = RDF::URI.new('http://schema.org/Article')
    SCHEMA_PAGE_START        = RDF::URI.new('http://schema.org/pageStart')
    SCHEMA_PAGE_END          = RDF::URI.new('http://schema.org/pageEnd')
    SCHEMA_PAGINATION        = RDF::URI.new('http://schema.org/pagination')
    SCHEMA_PUBLICATION_ISSUE = RDF::URI.new('http://schema.org/PublicationIssue')
    SCHEMA_ISSUE_NUMBER      = RDF::URI.new('http://schema.org/issueNumber')
    SCHEMA_PUBLICATION_VOLUME = RDF::URI.new('http://schema.org/PublicationVolume')
    SCHEMA_VOLUME_NUMBER     = RDF::URI.new('http://schema.org/volumeNumber')
    SCHEMA_PERIODICAL        = RDF::URI.new('http://schema.org/Periodical')
    SCHEMA_ISSN              = RDF::URI.new('http://schema.org/issn')
    SCHEMA_IS_SIMILAR_TO     = RDF::URI.new('http://schema.org/isSimilarTo')
    UMBEL_IS_LIKE            = RDF::URI.new('http://umbel.org/umbel#isLike')
    SCHEMA_AWARDS            = RDF::URI.new('http://schema.org/awards')
    SCHEMA_CONTENT_RATING    = RDF::URI.new('http://schema.org/contentRating')
    SCHEMA_GENRE             = RDF::URI.new('http://schema.org/genre')
    SCHEMA_ILLUSTRATOR       = RDF::URI.new('http://schema.org/illustrator')
    SCHEMA_COPYRIGHT_YEAR    = RDF::URI.new('http://schema.org/copyrightYear')
    SCHEMA_BOOK_FORMAT       = RDF::URI.new('http://schema.org/bookFormat')
    SCHEMA_EDITOR            = RDF::URI.new('http://schema.org/editor')
    SCHEMA_AUDIENCE          = RDF::URI.new('http://schema.org/audience')
    SCHEMA_AUDIENCE_TYPE     = RDF::URI.new('http://schema.org/audienceType')
    WDRS_DESCRIBED_BY        = RDF::URI.new('http://www.w3.org/2007/05/powder-s#describedby')
    VOID_IN_DATASET          = RDF::URI.new('http://rdfs.org/ns/void#inDataset')
    SCHEMA_DATE_MODIFIED     = RDF::URI.new('http://schema.org/dateModified')
  end
end