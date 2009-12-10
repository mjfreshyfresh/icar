class Speaker
  
  VOICES = {
    :speak => 'zarvox',
    :sing => 'Good News',
    :laugh => 'Hysterical'
  }
  
  def say(string, voice=nil)
    voice ||= VOICES[:speak]
    %x{say -v #{voice} #{string}}
  end
  
end