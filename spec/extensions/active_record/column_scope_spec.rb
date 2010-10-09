require File.dirname(__FILE__) + '/../../spec_helper'

describe "Active record" do
  describe "column scope" do
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

    it "should not be defined for already inherited abstract classes" do
      class Foo; def self.subclasses; [Bar] end; end
      class Bar < Foo;
        def self.abstract_class?; true; end;
        def self.columns; raise ActiveRecord::StatementInvalid.new("Error"); end;
      end
      Foo.send(:include, Blazy::Extensions::ActiveRecord::ColumnScope)

      Bar.respond_to?(:with_dummy_column).should be_false

      remove_constants(:Foo, :Bar)
    end

    it "should not be defined for newly inherited abstract classes" do
      class AbstractProject < ActiveRecord::Base
        self.abstract_class = true
        def self.columns; [stub("column", :name => "dummy_column")]; end
      end

      AbstractProject.respond_to?(:with_dummy_column).should be_false

      remove_constants(:AbstractProject)
    end
  end
end