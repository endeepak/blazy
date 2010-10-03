require File.dirname(__FILE__) + '/active_record/fixnum'

ActiveRecord::Base.send(:include, Blazy::Extensions::ActiveRecord::Fixnum)
