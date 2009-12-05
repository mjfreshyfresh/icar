require 'rubygems'
require 'twitter'

require File.join("#{File.expand_path(File.dirname(__FILE__))}/../model", 'icar.rb')
include Stepchange::ICar

puts "Tweeter ready."

@scene = Scene.find_or_create_by_title('icar')
@scene.start

class Tweeter

  def self.tweet(s)
    puts "Tweet it!"
    httpauth = Twitter::HTTPAuth.new('stratton@stepchangegroup.com', 'st3pch@ng3')
    client = Twitter::Base.new(httpauth)
    client.update(s)
  end

end

loop do
  message = @scene.lines_to_tweet.last
  if message
    Tweeter.tweet(message.text)
    message.update(:tweeted => true)
  end
  sleep 10
end
