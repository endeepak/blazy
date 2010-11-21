class ActiveRecord::Base
  class << self
    {:-  => :find, :[]  => :find, :f => :first, :a => :all, :l => :last}.each do |new_name, method|
      eval "alias #{new_name} #{method}"
    end
  end
end

Dir.glob(File.join(File.dirname(__FILE__),'active_record','*.rb')).each { |file| require file }
ActiveRecord::Base.send(:include, Blazy::Extensions::ActiveRecord::Object)
ActiveRecord::Base.send(:include, Blazy::Extensions::ActiveRecord::Fixnum)
ActiveRecord::Base.send(:include, Blazy::Extensions::ActiveRecord::ColumnScope)
