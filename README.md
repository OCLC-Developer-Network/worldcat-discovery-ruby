# Worldcat::Discovery

Ruby gem wrapper around WorldCat Discovery API. 

## Installation

TODO: Write installation instructions here

## Usage

```ruby
require 'worldcat/discovery'

wskey = OCLC::Auth::WSKey.new('api-key', 'api-key-secret')
WorldCat::Discovery.configure(wskey)

bib = WorldCat::Discovery::Bib.find(255034622)

bib.name         # => "Programming Ruby."
bib.id           # => #<RDF::URI:0x3feb33057c70 URI:http://www.worldcat.org/oclc/255034622>
bib.id.to_s      # => "http://www.worldcat.org/oclc/255034622"
bib.author       # => <WorldCat::Discovery::Person:70279384406040 @subject: http://viaf.org/viaf/107579098> 
bib.author.name  # => "Thomas, David."
bib.contributors.map{|contributor| contributor.name} # => [" Fowler, Chad.", "Hunt, Andrew."]
```


