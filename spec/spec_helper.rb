require 'rubygems'
gem 'factory_girl', '=1.2.4'

require 'spec'
require 'active_record'
require 'factory_girl'
require File.dirname(__FILE__)+ '/active_model'

Dir["#{File.expand_path(File.dirname(__FILE__) + '/../lib/*.rb')}"].each { |file|  require file }

load(File.dirname(__FILE__) + "/db/init.rb")

Spec::Runner.configure do |config|
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