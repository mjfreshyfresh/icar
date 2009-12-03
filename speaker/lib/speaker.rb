class Speaker
  
  def say(string)
    %x{say #{string}}
  end
  
end