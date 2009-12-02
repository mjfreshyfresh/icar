# port = SerialPort.new("/dev/tty.usbserial-A8004Jgd", 9600, 8, 1, SerialPort::NONE)
# port.flow_control = (SerialPort::HARD | SerialPort::SOFT)  
# 
# while true do
#   printf("%c", port.getc)
# end
# 

require 'serialport.so'

class Serial
  
  attr_accessor :port

  def initialize
    @port = SerialPort.new("/dev/tty.usbserial-A8004Jgd", 9600, 8, 1, SerialPort::NONE)
    @port.flow_control = (SerialPort::HARD | SerialPort::SOFT)
        # optionally configure timeouts
    #    @port.timeouts(0, 200, 0, 0, 0)    
  end

  def read_sensor
    #@port.write("Reading Sensort") 

#    response = @port.read(39)



    # pressure_str,unit_str = response.split(';')
    # pressure = pressure_str.split[1].to_f
    # unit = unit_str.split[1].downcase

    return "Done: #{@port.read}"
  end
end
