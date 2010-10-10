class ActiveRecord::Base
  named_scope :with, lambda { |conditions| {:conditions => conditions } }
  named_scope :limit, lambda { |limit| {:limit => limit} }
  named_scope :order, lambda { |order| {:order => order} }
  named_scope :select, lambda { |*columns| {:select => columns} }

  class << self
    {:where => :with, :-  => :find, :f => :first, :a => :all, :l => :last}.each do |new_name, method|
      eval "alias #{new_name} #{method}"
    end
  end
end

Dir.glob(File.join(File.dirname(__FILE__),'active_record','*.rb')).each { |file| require file }
ActiveRecord::Base.send(:include, Blazy::Extensions::ActiveRecord::ScopeMerge)
ActiveRecord::Base.send(:include, Blazy::Extensions::ActiveRecord::Fixnum)
ActiveRecord::Base.send(:include, Blazy::Extensions::ActiveRecord::ColumnScope)
