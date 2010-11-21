module Rails
  #HACKTAG:: Load all model from rails app model instead of lazy load  - Testing this?
  def self.load_all_models
    return false unless Rails.root
    load_all('app','models','**','*.rb') and return true
  end

private
  def self.load_all(*paths)
    Dir.glob(File.join(self.root,*paths)).each { |file| require_dependency file }
  end
end