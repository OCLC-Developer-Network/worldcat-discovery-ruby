module WorldCat
  module Discovery
    
    GENERIC_RESOURCE  = RDF::URI.new('http://www.w3.org/2006/gen/ont#ContentTypeGenericResource')
    SCHEMA_ABOUT      = RDF::URI.new('http://schema.org/about')
    SCHEMA_AUTHOR     = RDF::URI.new('http://schema.org/author')
    SCHEMA_NAME       = RDF::URI.new('http://schema.org/name')
    SCHEMA_INTANGIBLE = RDF::URI.new('http://schema.org/Intangible')
    OCLC_NUMBER       = RDF::URI.new('http://purl.org/library/oclcnum')
    
  end
end