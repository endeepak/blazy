module Blazy
  module Extensions
    module ActiveRecord
      def self.included(klass)
        klass.extend ClassMethods
        klass.send(:subclasses).each {|subclass| subclass.add_extension_to_fixnum}
      end

      module ClassMethods
        def inherited(klass)
          klass.add_extension_to_fixnum
          super
        end

        def add_extension_to_fixnum
          downcased_model_name = self.class_name.underscore
          pluralized_downcased_model_name = downcased_model_name.pluralize
          definition = <<-METHOD_DEFINITION
                            class ::Fixnum
                              def #{downcased_model_name}
                                record_to_find = self==1 ? :first : :all
                                #{self}.find(record_to_find, :limit => self)
                              end
                              alias #{pluralized_downcased_model_name} #{downcased_model_name}
                            end
                        METHOD_DEFINITION
          eval(definition)
        end
      end
    end
  end
end

ActiveRecord::Base.send(:include, Blazy::Extensions::ActiveRecord)
