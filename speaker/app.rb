require 'model/icar'
include Stepchange::ICar

puts "Speaker ready."

@scene = Scene.find_or_create_by_title('icar')
@scene.start(true)

loop do
  @scene.play_next
  sleep 0.2
end