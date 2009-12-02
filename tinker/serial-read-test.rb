# Plug in arduino with a sensor on the analog port

require 'serialport.so'


port = SerialPort.new("/dev/tty.usbserial-A8004Jgd", 9600, 8, 1, SerialPort::NONE)
port.flow_control = (SerialPort::HARD | SerialPort::SOFT)  

while true do
  printf("%c", port.getc)
end