require File.dirname(__FILE__) + '/../spec_helper'

describe "ActiveRecord" do
  describe "limit" do
    it "should limit the results to given number" do
      project_1 = Factory(:project)
      project_2 = Factory(:project)
      project_3 = Factory(:project)

      Project.limit(2).collect(&:id).should == [project_1.id, project_2.id]
    end
  end

  describe "with" do
    it "should allow search for condition with single value" do
      project_1 = Factory(:project, :name => "be lazy")
      project_2 = Factory(:project, :name => "dont be lazy")

      project = Project.with(:name => 'be lazy').first
      project.id.should == project_1.id
    end

    it "should allow search for condition with multiple values" do
      project_1 = Factory(:project, :priority => 1)
      project_2 = Factory(:project, :priority => 2)
      project_3 = Factory(:project, :priority => 3)

      Project.with(:priority => [2,3]).collect(&:id).should == [project_2.id, project_3.id]
    end

    it "should allow search with chaining conditions" do
      project_1 = Factory(:project, :name => 'blazy', :priority => 1)
      project_2 = Factory(:project, :name => 'blazy', :priority => 2)
      project_3 = Factory(:project, :name => 'be lazy', :priority => 1)

      Project.with(:name => 'blazy').with(:priority => 1).collect(&:id).should == [project_1.id]
    end

    it "should allow search for condition in sql form" do
      project_1 = Factory(:project, :name => "blazy")
      project_2 = Factory(:project, :name => "dont be lazy")
      project_3 = Factory(:project, :name => "be smart")

      Project.with("name like '%lazy%'").collect(&:id).should == [project_1.id, project_2.id]
    end
  end
end
