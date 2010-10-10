require File.dirname(__FILE__) + '/../spec_helper'

describe "ActiveRecord" do
  ['with','where'].each do |method|
    describe "#{method}" do
      it "should allow search for condition with single value" do
        project_1 = Factory(:project, :name => "be lazy")
        project_2 = Factory(:project, :name => "dont be lazy")

        project = Project.send(method, :name => 'be lazy').first
        project.id.should == project_1.id
      end

      it "should allow search for condition with multiple values" do
        project_1 = Factory(:project, :priority => 1)
        project_2 = Factory(:project, :priority => 2)
        project_3 = Factory(:project, :priority => 3)

        Project.send(method, :priority => [2,3]).collect(&:id).should == [project_2.id, project_3.id]
      end

      it "should allow search with chaining conditions" do
        project_1 = Factory(:project, :name => 'blazy', :priority => 1)
        project_2 = Factory(:project, :name => 'blazy', :priority => 2)
        project_3 = Factory(:project, :name => 'be lazy', :priority => 1)

        Project.send(method, :name => 'blazy').with(:priority => 1).collect(&:id).should == [project_1.id]
      end

      it "should allow search for condition in sql form" do
        project_1 = Factory(:project, :name => "blazy")
        project_2 = Factory(:project, :name => "dont be lazy")
        project_3 = Factory(:project, :name => "be smart")

        Project.send(method, "name like '%lazy%'").collect(&:id).should == [project_1.id, project_2.id]
      end

      it "should allow search for or conditions in sql form" do
        project_1 = Factory(:project, :name => "be lazy")
        project_2 = Factory(:project, :name => "dont be lazy")
        project_3 = Factory(:project, :name => "be smart")

        Project.send(method, "name = 'be lazy' OR name = 'be smart' ").collect(&:id).should == [project_1.id, project_3.id]
      end
    end
  end

  describe "limit" do
    it "should limit the results to given number" do
      project_1 = Factory(:project)
      project_2 = Factory(:project)
      project_3 = Factory(:project)

      Project.limit(2).collect(&:id).should == [project_1.id, project_2.id]
    end
  end

  describe "order" do
    it "should order by give column the results in given order" do
      project_2 = Factory(:project, :priority => 2)
      project_3 = Factory(:project, :priority => 3)
      project_1 = Factory(:project, :priority => 1)

      Project.order('priority').collect(&:id).should == [project_1.id, project_2.id, project_3.id]
      Project.order('priority ASC').collect(&:id).should == [project_1.id, project_2.id, project_3.id]
      Project.order('priority DESC').collect(&:id).should == [project_3.id, project_2.id, project_1.id]
    end
  end

  describe "select" do
    it "should select only given column" do
      project_1 = Factory(:project, :name => "Project")

      project = Project.select('id').first
      project.id.should == project_1.id
      project.attributes.keys.should == ['id']
    end

    it "should select given columns" do
      project_1 = Factory(:project, :name => "Project", :priority => 1)

      project = Project.select('name, priority').first
      project.attributes.keys.should == ['name','priority']
    end
  end

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
