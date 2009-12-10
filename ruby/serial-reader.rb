# Plug in arduino with a sensor on the analog port
require 'serialport.so'

require File.join("#{File.expand_path(File.dirname(__FILE__))}/../model", 'icar.rb')
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
      message = message.strip
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
      "I'm sorry you're lame and can't twitter", "I heart racing!", '@LindseyK this race is for you!',
      'Engage!', 'Mov-in mov-in mov-in!', 'I say, we must move forward, not backward, upward not forward,and always twirling, twirling, twirling towards freedom',
      'This is a race that means go!', 'you call that racing?', 'pistons popping aint no stopping now']
  end
  
  def neutral
    randomize ["Push me push me!", "Can we race now? How about now?", "I'm ready are you?", 
      "Show me yours and I'll show you mine.", "Wanna go ride bikes?", "Do i make you randy?",
      "I love beer, will you give me a beer", "Beer makes me go", "My icar is smarter than your honor student"]
  end
  
  def up
    randomize ["Put me down, Put me down", "How would you feel if i just came and picked you up?", 
      "why must everyone touch me?", "Stop it stop it, you're touch me", "yes yes yes right there!", 
      'I love beer, will you give me a beer', 'ooooh that tickles', 'pet me im smooth', 'a little lower a little lower',
      'watch the wires!', "Show me yours and I'll show you mine.", "My i car is smarter than your honor student", 
      'yeeeeeeeehawwwwww', 'power me up not pick me up', 'is that how you treat your i car?', 'did you fart?',
      'my i car has a first name its i c ey r', 'dont click submit, just sumbit', 'let me go!', 'license and id please',
      'who left you in charge?', 'how can i get a beer around here?', 'mmmmmmmm beer']  
  end
  
  private
  
  def randomize(arr)
    arr.sort_by{ rand }.sort_by{ rand }.sort_by{ rand }.last
  end
  
  def do_a_line(line, voice=nil)
    puts "Saving line #{line}"
    scene = Scene.find_or_create_by_title('icar')
    scene.speak(line, voice)
  end
  
end


# Fire it up!
ms = MotherShip.new
ms.connect