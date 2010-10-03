class Class
  def class_name
    self.name.split('::').last
  end
end