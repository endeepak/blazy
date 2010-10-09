module Blazy
  module Extensions
    module ActiveRecord
      module ColumnScope
        def self.included(klass)
          klass.extend ClassMethods
          klass.send(:subclasses).each {|subclass| subclass.add_column_scope}
        end

        module ClassMethods
          def inherited(klass)
            super
            klass.add_column_scope
          end

          def add_column_scope
            self.columns.each do |column|
              self.named_scope "with_#{column.name}", lambda { |*params| {:conditions => { column.name => params } } }
            end
          end
        end
      end
    end
  end
end