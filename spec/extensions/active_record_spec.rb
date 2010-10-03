require File.dirname(__FILE__) + '/../spec_helper'

describe "ActiveRecord extensions" do
  describe "for new inheritors of active record" do
    it "should find 1 model" do
       project = Factory(:project)

       1.project.should_not be_nil
       1.project.id.should == project.id
    end

    it "should find multiple models" do
       project_1 = Factory(:project)
       project_2 = Factory(:project)

       2.projects.collect(&:id).should == [project_1.id, project_2.id]
    end
  end

  describe "for existing inheritors of class" do
    before(:each) do
      class Foo; def self.subclasses; [Bar] ; end; end
      class Bar < Foo; end;
      Foo.send(:include, Blazy::Extensions::ActiveRecord)
    end

    after(:each) do
      remove_constants(:Foo, :Bar)
    end

    it "should find 1 model" do
      model = Bar.new
      Bar.expects(:find).with(:first, :limit => 1).returns(model)

      1.bar.should == model
    end

    it "should find multiple models" do
      model_1 = Bar.new
      model_2 = Bar.new
      Bar.expects(:find).with(:all, :limit => 2).returns([model_1,model_2])

      2.bars.should == [model_1,model_2]
    end
  end

  describe "for camel case named inheritors" do
    before(:each) do
      class ModelClass; def self.subclasses; [ModelSubClass] ; end; end
      class ModelSubClass < ModelClass; end;
      ModelSubClass.send(:include, Blazy::Extensions::ActiveRecord)
    end

    after(:each) do
      remove_constants(:ModelClass, :ModelSubClass)
    end

    it "should find 1 model" do
      model = ModelSubClass.new
      ModelSubClass.expects(:find).with(:first, :limit => 1).returns(model)

      1.model_sub_class.should == model
    end

    it "should find multiple models" do
      model_1 = ModelSubClass.new
      model_2 = ModelSubClass.new
      ModelSubClass.expects(:find).with(:all, :limit => 2).returns([model_1,model_2])

      2.model_sub_classes.should == [model_1,model_2]
    end
  end

  describe "for inheritors not in defualt name space" do
    before(:each) do
      module Booga
        class Foo; def self.subclasses; [Bar] ; end; end
        class Bar < Foo; end;
      end
      Booga::Foo.send(:include, Blazy::Extensions::ActiveRecord)
    end

    after(:each) do
      remove_constants(:Booga)
    end

    it "should find 1 model" do
      model = Booga::Bar.new
      Booga::Bar.expects(:find).with(:first, :limit => 1).returns(model)

      1.bar.should == model
    end

    it "should find multiple models" do
      model_1 = Booga::Bar.new
      model_2 = Booga::Bar.new
      Booga::Bar.expects(:find).with(:all, :limit => 2).returns([model_1,model_2])

      2.bars.should == [model_1,model_2]
    end
  end
end