class Line

  include DataMapper::Resource

  property :id, Serial
  property :text, Text, :lazy => false
  property :spoken, Boolean, :nullable => false, :default => false

  belongs_to :scene

end