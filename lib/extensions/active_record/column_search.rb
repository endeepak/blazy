module Blazy
  module Extensions
    module ActiveRecord
      module ColumnSearch
        def self.included(klass)
          klass.extend ClassMethods
          klass.send(:subclasses).each {|subclass| subclass.add_column_search}
        end

        module ClassMethods
          def inherited(klass)
            super
            klass.add_column_search
          end

          def add_column_search
            self.named_scope "with", lambda { |conditions| {:conditions => conditions } }
            self.add_column_specific_scope
          end

          def add_column_specific_scope
            self.columns.each do |column|
              self.named_scope "with_#{column.name}", lambda { |*params| {:conditions => { column.name => params } } }
            end
          end
        end
      end
    end
  end
end