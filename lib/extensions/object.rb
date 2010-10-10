Dir.glob(File.join(File.dirname(__FILE__),'object','*.rb')).each { |file| require file }

Object.send(:include, Blazy::Extensions::Object::Name)
