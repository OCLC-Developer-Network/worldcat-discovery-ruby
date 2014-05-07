module WorldCat
  module Discovery
    
    GENERIC_RESOURCE  = RDF::URI.new('http://www.w3.org/2006/gen/ont#ContentTypeGenericResource')
    SCHEMA_ABOUT      = RDF::URI.new('http://schema.org/about')
    SCHEMA_AUTHOR     = RDF::URI.new('http://schema.org/author')
    SCHEMA_NAME       = RDF::URI.new('http://schema.org/name')
    SCHEMA_INTANGIBLE = RDF::URI.new('http://schema.org/Intangible')
    OCLC_NUMBER       = RDF::URI.new('http://purl.org/library/oclcnum')
    WORK_EXAMPLE      = RDF::URI.new('http://schema.org/workExample')
    EXAMPLE_OF_WORK   = RDF::URI.new('http://schema.org/exampleOfWork')
    NUMBER_OF_PAGES   = RDF::URI.new('http://schema.org/numberOfPages')
    DATE_PUBLISHED    = RDF::URI.new('http://schema.org/datePublished')
    
  end
end