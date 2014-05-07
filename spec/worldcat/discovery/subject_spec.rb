require_relative '../../spec_helper'

describe WorldCat::Discovery::Person do
  context "when loading an author as a Person resource from RDF data" do
    before(:all) do
      rdf = body_content("30780581.rdf")
      Spira.repository = RDF::Repository.new.from_rdfxml(rdf)
      
      philosophy = RDF::URI.new('http://id.worldcat.org/fast/1060777')
      @subject = philosophy.as(WorldCat::Discovery::Subject)
      # 
      # gr_uri  = RDF::URI.new('http://www.w3.org/2006/gen/ont#ContentTypeGenericResource')
      # generic_resource = Spira.repository.query(:predicate => RDF.type, :object => gr_uri).first
      # resource = generic_resource.subject.as(WorldCat::Discovery::GenericResource)
      # @person = resource.about.author.subject.as(WorldCat::Discovery::Person)
    end
    
    it "should produce have the right class" do 
      @subject.class.should == WorldCat::Discovery::Subject
    end
    
    it "should have the right name" do
      @subject.name.should == 'Philosophy.'
    end
    
    it "should have the right id" do
      @subject.id.should == 'http://id.worldcat.org/fast/1060777'
    end
    
    it "should have the right type" do
      @subject.type.should == 'http://schema.org/Intangible'
    end
  end
end