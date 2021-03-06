require 'rubygems'
require 'active_record'
require 'rspec'
require 'factory_girl'
require File.dirname(__FILE__)+ '/base_without_table'
require File.dirname(__FILE__)+ '/factories'

Dir["#{File.expand_path(File.dirname(__FILE__) + '/../lib/*.rb')}"].each { |file|  require file }

load(File.dirname(__FILE__) + "/db/init.rb")

RSpec.configure do |config|
  config.mock_with :mocha
  config.before(:each) { Project.delete_all }
end

class Project < ActiveRecord::Base
end

def remove_constants(*constants)
  return if constants.blank?
  constants.flatten.each do |const|
    Object.send(:remove_const,const) if Object.const_defined?(const)
  end
end