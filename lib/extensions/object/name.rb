module Blazy
  module Extensions
    module Object
      module Name
        def singular_name
          self.name.demodulize.underscore
        end

        def plural_name
          self.singular_name.pluralize
        end
      end
    end
  end
end