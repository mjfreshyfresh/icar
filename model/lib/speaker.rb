class Speaker
  
  VOICES = {
    :speak => 'Alex',
    :sing => 'Good News',
    :laugh => 'Hysterical'
  }
  
  def say(string, voice=nil)
    voice ||= VOICES[:speak]
    %x{say -v #{voice} #{string}}
  end
  
end