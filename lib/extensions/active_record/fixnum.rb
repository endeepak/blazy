module Blazy
  module Extensions
    module ActiveRecord
      module Fixnum
        def self.included(klass)
          klass.extend ClassMethods
          klass.send(:descendants).each {|subclass| subclass.add_extension_to_fixnum}
        end

        module ClassMethods
          def inherited(klass)
            klass.add_extension_to_fixnum
            super
          end

          def add_extension_to_fixnum
            eval <<-METHOD
                    class ::Fixnum
                      def #{self.singular_name}
                        #{self}.limit(self)
                      end
                      alias #{self.plural_name} #{self.singular_name}
                    end
                METHOD
          end
        end
      end

    end
  end
end
