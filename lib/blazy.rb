require 'rubygems'
require 'active_record'
require 'active_support/inflector'

require 'extensions/object'
require 'extensions/active_record'
require 'extensions/rails'

module Blazy
  def self.init
    Rails.load_all_models
  end
end
