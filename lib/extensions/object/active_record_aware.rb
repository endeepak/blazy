module Blazy
  module Extensions
    module Object
      module ActiveRecordAware
        #TODO: Refactor this
        def self.included(klass)
          ::ActiveRecord::Base.send(:subclasses).each do |subclass|
            klass.class_eval <<-METHOD
                                  def #{subclass.singular_name}
                                    #{subclass}.first
                                  end
                                METHOD
            klass.class_eval <<-METHOD
                                  def #{subclass.plural_name}
                                    #{subclass}.all
                                  end
                                METHOD
          end
        end
      end
    end
  end
end