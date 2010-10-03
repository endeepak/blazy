require 'rubygems'
require 'active_record'
require 'active_support/inflector'

require 'extensions/active_model'
require 'extensions/active_record'

Dir.glob(File.join(RAILS_ROOT,'app','models','**','*.rb')).each { |file| require_dependency file } if defined?(RAILS_ROOT)