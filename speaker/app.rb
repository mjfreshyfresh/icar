require File.join("#{File.expand_path(File.dirname(__FILE__))}/../model", 'icar.rb')
include Stepchange::ICar

puts "Speaker ready."

@scene = Scene.find_or_create_by_title('icar')
@scene.start(true)

loop do
  @scene.play_next
  sleep 0.1
end