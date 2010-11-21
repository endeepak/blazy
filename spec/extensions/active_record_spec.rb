require File.dirname(__FILE__) + '/../spec_helper'

describe "ActiveRecord" do
  describe "aliases" do
    describe "-id" do
      it "should find model with id" do
         Factory(:project, :id => 007)
         Factory(:project, :id => 9)

         project = Project-007

         project.should == Project.find(007)
      end
    end

    describe "[id]" do
      it "should find model with id" do
         Factory(:project, :id => 007)
         Factory(:project, :id => 9)

         Project[007].should == Project.find(007)
      end
    end

    describe "f" do
      it "should find first model" do
         Factory(:project)
         Factory(:project)
         Project.f.should == Project.first
      end
    end

    describe "l" do
      it "should find last model" do
         Factory(:project)
         Factory(:project)
         Project.l.should == Project.last
      end
    end

    describe "a" do
      it "should find all models" do
         Factory(:project)
         Factory(:project)
         Project.a.should == Project.all
      end
    end
  end
end
