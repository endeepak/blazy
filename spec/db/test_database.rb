class TestDatabase
  def self.initialize
    config = YAML::load(IO.read(File.dirname(__FILE__) + '/database.yml'))
    ActiveRecord::Base.logger = Logger.new(File.dirname(__FILE__) + "/../../blazy.log")
    database = ENV['DB'] || 'mysql'
    ActiveRecord::Base.establish_connection(config[database])
    ActiveRecord::Migration.verbose = false
    load(File.dirname(__FILE__) + "/schema.rb")
  end
end