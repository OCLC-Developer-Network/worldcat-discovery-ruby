module WorldCat
  module Discovery
    class Person < Spira::Base
      
      property :name, :predicate => SCHEMA_NAME, :type => XSD.string
      
    end
  end
end