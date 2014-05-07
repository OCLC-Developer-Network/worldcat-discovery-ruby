module WorldCat
  module Discovery
    
    GENERIC_RESOURCE       = RDF::URI.new('http://www.w3.org/2006/gen/ont#ContentTypeGenericResource')
    SCHEMA_ABOUT           = RDF::URI.new('http://schema.org/about')
    SCHEMA_AUTHOR          = RDF::URI.new('http://schema.org/author')
    SCHEMA_NAME            = RDF::URI.new('http://schema.org/name')
    SCHEMA_BOOK            = RDF::URI.new('http://schema.org/Book')
    SCHEMA_PERSON          = RDF::URI.new('http://schema.org/Person')
    SCHEMA_INTANGIBLE      = RDF::URI.new('http://schema.org/Intangible')
    SCHEMA_WORK_EXAMPLE    = RDF::URI.new('http://schema.org/workExample')
    SCHEMA_EXAMPLE_OF_WORK = RDF::URI.new('http://schema.org/exampleOfWork')
    SCHEMA_NUMBER_OF_PAGES = RDF::URI.new('http://schema.org/numberOfPages')
    SCHEMA_DATE_PUBLISHED  = RDF::URI.new('http://schema.org/datePublished')
    SCHEMA_IN_LANGUAGE     = RDF::URI.new('http://schema.org/inLanguage')
    SCHEMA_PUBLISHER       = RDF::URI.new('http://schema.org/publisher')
    OWL_SAME_AS            = RDF::URI.new('http://www.w3.org/2002/07/owl#sameAs')
    LIB_OCLC_NUMBER        = RDF::URI.new('http://purl.org/library/oclcnum')
    LIB_PLACE_OF_PUB       = RDF::URI.new('http://purl.org/library/placeOfPublication')
    
  end
end