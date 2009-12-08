class Scene
  
  include DataMapper::Resource
  require File.join("#{File.expand_path(File.dirname(__FILE__))}", 'speaker.rb')
  require File.join("#{File.expand_path(File.dirname(__FILE__))}", 'line.rb')

  property :id, Serial
  property :title, String

  has n, :lines

  attr_accessor :stopped
  attr_accessor :speaker

  def start(speaking=false)
    @speaker = Speaker.new
    self.lines.create(:text => "Hello - I am Eye Car Two Point Oh") if lines_to_speak.empty? && speaking
    true
  end

  def speak(text, voice=nil)
    self.lines.create(:text=>text, :voice => voice)
  end

  def laugh(text)
    self.lines.create(:text=>text, :voice => Speaker::VOICES[:laugh])
  end
  
  def tweet(text)
    self.lines.create(:text=>text, :tweetable=>true)
  end
  
  def lines_to_speak
    self.lines(:spoken => false).unexpired
  end
  
  def lines_to_tweet
    self.lines(:tweetable => true, :tweeted => false)
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
      voice = line.voice || nil
      @speaker.say(line.text, voice)
      line.update(:spoken => true)
    end
    stopped = true
  end

end