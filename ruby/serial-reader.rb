# Plug in arduino with a sensor on the analog port
require 'serialport.so'

require '../model/icar.rb'
include Stepchange::ICar

class MotherShip
  attr_accessor :port

  def initialize
    puts "Starting the MotherShip!"
    DataMapper.setup(:default, 'mysql://root@localhost/icar')
    @port = SerialPort.new("/dev/tty.usbserial-A600akW1", 9600, 8, 1, SerialPort::NONE)
    @port.flow_control = (SerialPort::HARD | SerialPort::SOFT)      
  end

  def connect
    puts "Connected."
    while true do
      message = @port.gets
      puts message
      case message
      when 'F'
        do_a_line(forward)        
      when 'N'
        do_a_line(neutral)                
      when 'Z'
        do_a_line(up)                
      else
        puts "WTF does #{message} mean?"
      end
    end    
  end
  
  def forward
    randomize ["I'm racing beeotches!", "Go go go get outta my way!", "Eat my saw dust", 
      "Here we go yo", "My grandma races faster than you!", "Do you call that racing?", 
      "I'm sorry you're lame and can't twitter", "I heart racing!"]
  end
  
  def neutral
    randomize ["Push me push me!", "Can we race now? How about now?", "I'm ready are you?", 
      "Show me yours and I'll show you mine.", "Wanna go ride bikes?", "Do i make you randy?",
      "I love beer, will you give me a beer", "Beer makes me go", "My icar is smarter than your honor student"]
  end
  
  def up
    randomize ["Put me down, Put me down", "How would you feel if i just came and picked you up?", 
      "why must everyone touch me?", "Stop it stop it, you're touch me", "yes yes yes right there!"]  
  end
  
  private
  
  def randomize(arr)
    arr.sort_by{ rand }.first
  end
  
  def do_a_line(line)
    puts "Saving line #{line}"
    scene = Scene.find_or_create_by_title('icar')
    scene.lines.create(:text=>line)
  end
  
end


# Fire it up!
ms = MotherShip.new
ms.connect