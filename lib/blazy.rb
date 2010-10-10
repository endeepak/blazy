require 'rubygems'
require 'active_record'
require 'active_support/inflector'

require 'extensions/object'
require 'extensions/active_record'

#HACKTAG:: Load all model from rails app model instead of lazy load  - Testing this?
Dir.glob(File.join(RAILS_ROOT,'app','models','**','*.rb')).each { |file| require_dependency file } if defined?(RAILS_ROOT)