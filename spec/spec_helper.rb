require "rubygems"

require "bundler"
Bundler.setup

require 'rspec/core'
require 'rspec/mocks'

$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__)))
$LOAD_PATH.unshift(File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib')))

require_relative '../lib/application'
require_relative '../lib/checkout'
require_relative '../lib/agoda_api'
require_relative '../lib/booking'


RSpec.configure do |config|

end

alias running lambda