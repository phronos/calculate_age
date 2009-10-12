$:.unshift(File.dirname(__FILE__)+'/../lib')
RAILS_ROOT = File.dirname(__FILE__)

ENV['TZ'] = 'UTC'

require 'rubygems'
require 'test/unit'

require 'active_support'
# require 'active_support/test_case'


require "#{File.dirname(__FILE__)}/../init"

require 'time_warp'