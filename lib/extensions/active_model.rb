module Blazy
  module ActiveModel
    def self.included(klass)
      klass.extend ClassMethods
    end

    module ClassMethods
      def -(id)
        self.find(id)
      end
    end
  end
end

ActiveRecord::Base.send(:include, Blazy::ActiveModel)