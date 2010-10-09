Dir.glob(File.join(File.dirname(__FILE__),'active_record','*.rb')).each { |file| require file }

ActiveRecord::Base.send(:include, Blazy::Extensions::ActiveRecord::Fixnum)
ActiveRecord::Base.send(:include, Blazy::Extensions::ActiveRecord::ColumnSearch)
