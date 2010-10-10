require File.dirname(__FILE__) + '/../../spec_helper'

describe "Active Record Aware" do
  Object.send(:include, Blazy::Extensions::Object::ActiveRecordAware)

  it "should list a model" do
    Factory(:project)

    project.should == Project.first
  end

  it "should list a models" do
    Factory(:project)
    Factory(:project)

    projects.should == Project.all
  end
end

