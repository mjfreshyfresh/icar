class Line

  include DataMapper::Resource

  property :id, Serial
  property :text, Text, :lazy => false
  property :spoken, Boolean, :nullable => false, :default => false
  property :tweeted, Boolean, :nullable => false, :default => false
  property :tweetable, Boolean, :nullable => false, :default => false
  property :speakable, Boolean, :nullable => false, :default => true

  property :voice, String

  belongs_to :scene

end