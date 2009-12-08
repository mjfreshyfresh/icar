class Line

  include DataMapper::Resource

  VALID_FOR_SECONDS = 2

  property :id, Serial
  property :text, Text, :lazy => false
  property :spoken, Boolean, :nullable => false, :default => false
  property :tweeted, Boolean, :nullable => false, :default => false
  property :tweetable, Boolean, :nullable => false, :default => false
  property :speakable, Boolean, :nullable => false, :default => true
  property :created_at, DateTime
  property :updated_at, DateTime

  property :voice, String

  belongs_to :scene

  # Only speak lines that were recently created
  def self.unexpired(valid_for_seconds = VALID_FOR_SECONDS)
    all(:created_at.gte => DateTime.parse((Time.now - valid_for_seconds).to_s))
  end

end