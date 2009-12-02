# Plug in arduino with a sensor on the analog port
require 'serialport.so'

require 'rubygems'
require 'twitter'

class Foo

  def self.tweet(s)
    puts "Tweet it!"
    httpauth = Twitter::HTTPAuth.new('stratton@stepchangegroup.com', 'st3pch@ng3')
    client = Twitter::Base.new(httpauth)
    client.update(s)
  end

end

port = SerialPort.new("/dev/tty.usbserial-A600akW1", 9600, 8, 1, SerialPort::NONE)
port.flow_control = (SerialPort::HARD | SerialPort::SOFT)  

while true do
  message = port.gets
  puts message
  if message[0..0] == 'F'
    Foo.tweet("Message from iCar: #{message}")
  end
  #printf("%c", port.getc)
end
