require 'config/env.rb'

@scene = Scene.find_or_create_by_title('icar')
@scene.start

loop do
  @scene.play_next
  sleep 0.2
end