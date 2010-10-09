require File.dirname(__FILE__) + '/../../spec_helper'

describe "Active record" do
  describe "with_column_name" do
    it "should allow search for column equal to value" do
      project_1 = Factory(:project, :name => "be lazy")
      project_2 = Factory(:project, :name => "dont be lazy")

      project = Project.with_name('be lazy').first
      project.id.should == project_1.id
    end

    it "should allow search for column equal to one of the values" do
      project_1 = Factory(:project, :priority => 1)
      project_2 = Factory(:project, :priority => 2)
      project_3 = Factory(:project, :priority => 3)

      Project.with_priority(2,3).collect(&:id).should == [project_2.id, project_3.id]
    end

    it "should allow search with chaining condtions" do
      project_1 = Factory(:project, :name => 'blazy', :priority => 1)
      project_2 = Factory(:project, :name => 'blazy', :priority => 2)
      project_3 = Factory(:project, :name => 'be lazy', :priority => 1)

      Project.with_name('blazy').with_priority(1).collect(&:id).should == [project_1.id]
    end
  end
end