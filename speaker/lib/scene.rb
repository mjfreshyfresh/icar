class Scene
  
  include DataMapper::Resource
  require File.join('lib', 'speaker.rb')
  require File.join('lib', 'line.rb')

  property :id, Serial
  property :title, String

  has n, :lines

  attr_accessor :stopped
  attr_accessor :speaker

  def start
    @speaker = Speaker.new
    self.lines.create(:text => "Hello - I am Eye Car Two Point Oh") if lines_to_speak.empty?
    true
  end
  
  def lines_to_speak
    self.lines(:spoken => false)
  end

  def self.find_or_create_by_title(title)
    scene = Scene.first(:title => title)
    scene = Scene.create(:title => title) unless scene
    scene
  end

  def play_next
    stopped = false
    line = lines_to_speak.last
    if line
      @speaker.say(line.text) 
      line.update(:spoken => true)
    end
    stopped = true
  end

end