require 'rubygems'
gem 'dm-core', '>= 0.10.0'
require 'dm-core'
require File.join("#{File.expand_path(File.dirname(__FILE__))}/lib", 'scene.rb')

module Stepchange
  module ICar
    
    DataMapper.setup(:default, 'mysql://root@localhost/icar')

  end
end