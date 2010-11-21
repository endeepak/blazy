module Blazy
  module Extensions
    module ActiveRecord
      module ColumnScope
        def self.included(klass)
          klass.extend ClassMethods
          klass.send(:descendants).each {|subclass| subclass.add_column_scope unless subclass.abstract_class?}
        end

        module ClassMethods
          def inherited(klass)
            super
            klass.add_column_scope
          end

          def add_column_scope
            self.columns.each do |column|
              self.scope "with_#{column.name}", lambda { |*params| {:conditions => { column.name => params } } }
            end
          rescue ::ActiveRecord::ActiveRecordError => e
            puts "Failed to add column scope for #{self.name} : #{e.message}"
          end
        end
      end
    end
  end
end