require 'rubygems'
gem 'dm-core', '>= 0.10.0'
require 'dm-core'
DataMapper.setup(:default, 'mysql://root@localhost/icar')

require 'lib/scene.rb'
