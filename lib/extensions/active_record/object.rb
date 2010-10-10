module Blazy
  module Extensions
    module ActiveRecord
      module Object
        def self.included(klass)
          klass.extend ClassMethods
          klass.send(:subclasses).each {|subclass| subclass.add_extension_to_object}
        end

        module ClassMethods
          def inherited(klass)
            super
            klass.add_extension_to_object
          end

          def add_extension_to_object
            eval <<-METHOD
                      class ::Object
                        def #{self.singular_name}
                          #{self}.first
                        end
                      end
                    METHOD
            eval <<-METHOD
                      class ::Object
                        def #{self.plural_name}
                          #{self}.all
                        end
                      end
                    METHOD
          end
        end
      end
    end
  end
end