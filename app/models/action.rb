class Action < Spira::Base
  configure default_vocabulary: RDF::URI.new('http://example.org/vocab'),
            base_uri: "http://exampe.org/actions"
  property :name, type: String
end
