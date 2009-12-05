require 'rubygems'
require 'thor'

require File.join('model', 'icar.rb')

class Db < Thor
  
  desc "bootstrap ENV", "DESTRUCTIVE bootstrap of the database"
  def bootstrap
    DataMapper.auto_migrate!
  end

end

