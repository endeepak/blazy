require File.dirname(__FILE__) + '/../../spec_helper'

describe "Object." do
  describe "model" do
    it "should list first model" do
      Factory(:project)

      project.should == Project.first
    end
  end

  describe "models" do
    it "should list all models" do
      Factory(:project)
      Factory(:project)

      projects.should == Project.all
    end
  end
end

