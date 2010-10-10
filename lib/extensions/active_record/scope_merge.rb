module Blazy
  module Extensions
    module ActiveRecord
      module ScopeMerge
        def self.included(klass)
          klass.send(:subclasses).each {|subclass| subclass.scopes.reverse_merge!(klass.scopes) }
        end
      end
    end
  end
end