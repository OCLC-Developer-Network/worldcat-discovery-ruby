module WorldCat
  module Discovery
    
    GENERIC_RESOURCE  = RDF::URI.new('http://www.w3.org/2006/gen/ont#ContentTypeGenericResource')
    SCHEMA_ABOUT      = RDF::URI.new('http://schema.org/about')
    SCHEMA_AUTHOR     = RDF::URI.new('http://schema.org/author')
    SCHEMA_NAME       = RDF::URI.new('http://schema.org/name')
    SCHEMA_BOOK       = RDF::URI.new('http://schema.org/Book')
    SCHEMA_INTANGIBLE = RDF::URI.new('http://schema.org/Intangible')
    WORK_EXAMPLE      = RDF::URI.new('http://schema.org/workExample')
    EXAMPLE_OF_WORK   = RDF::URI.new('http://schema.org/exampleOfWork')
    NUMBER_OF_PAGES   = RDF::URI.new('http://schema.org/numberOfPages')
    DATE_PUBLISHED    = RDF::URI.new('http://schema.org/datePublished')
    IN_LANGUAGE       = RDF::URI.new('http://schema.org/inLanguage')
    OWL_SAME_AS       = RDF::URI.new('http://www.w3.org/2002/07/owl#sameAs')
    OCLC_NUMBER       = RDF::URI.new('http://purl.org/library/oclcnum')
    
  end
end