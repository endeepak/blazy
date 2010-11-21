require File.dirname(__FILE__) + '/../../spec_helper'

shared_examples_for "FixnumExtension" do
  it "should limit to single model" do
    scope = mock("scope")
    klass.expects(:limit).with(1).returns(scope)

    eval("1.#{model}").should == scope
  end

  it "should limit to multiple models" do
    scope = mock("scope")
    klass.expects(:limit).with(2).returns(scope)

    eval("2.#{models}").should == scope
  end
end

describe "ActiveRecord Fixnum extensions" do
  describe "for new inheritors of active record" do
    it "should limit to single model" do
       project = Factory(:project)

       1.project.collect(&:id).should == [project.id]
    end

    it "should limit to multiple models" do
       project_1 = Factory(:project)
       project_2 = Factory(:project)

       2.projects.collect(&:id).should == [project_1.id, project_2.id]
    end
  end

  describe "for new second level inheritors of class" do
    before(:each) do
      class Booga < ActiveRecord::BaseWithoutTable ; end
      Booga.send(:include, Blazy::Extensions::ActiveRecord::Fixnum)
      class Foo < Booga ; end
      class Bar < Foo; end;
    end

    after(:each) do
      remove_constants(:Booga, :Foo, :Bar)
    end

    def klass; Bar; end;
    def model; "bar"; end;
    def models; "bars"; end;

    it_should_behave_like "FixnumExtension"
  end

  describe "for existing first level inheritors of class" do
    before(:each) do
      class Foo; def self.descendants; [Bar] end; end
      class Bar < Foo; end;
      Foo.send(:include, Blazy::Extensions::ActiveRecord::Fixnum)
    end

    after(:each) do
      remove_constants(:Foo, :Bar)
    end

    def klass; Bar; end;
    def model; "bar"; end;
    def models; "bars"; end;

    it_should_behave_like "FixnumExtension"
  end

  describe "for existing second level inheritors of class" do
    before(:each) do
      class Booga; def self.descendants; [Foo, Bar] end; end
      class Foo < Booga ; end
      class Bar < Foo; end;
      Booga.send(:include, Blazy::Extensions::ActiveRecord::Fixnum)
    end

    after(:each) do
      remove_constants(:Booga, :Foo, :Bar)
    end

    def klass; Bar; end;
    def model; "bar"; end;
    def models; "bars"; end;

    it_should_behave_like "FixnumExtension"
  end

  describe "for camel case named inheritors" do
    before(:each) do
      class ModelClass < ActiveRecord::BaseWithoutTable; end
      class ModelSubClass < ModelClass; end;
      ModelSubClass.send(:include, Blazy::Extensions::ActiveRecord::Fixnum)
    end

    after(:each) do
      remove_constants(:ModelClass, :ModelSubClass)
    end

    def klass; ModelSubClass; end;
    def model; "model_sub_class"; end;
    def models; "model_sub_classes"; end;

    it_should_behave_like "FixnumExtension"
  end

  describe "for inheritors not in defualt name space" do
    before(:each) do
      module Booga
        class Foo < ActiveRecord::BaseWithoutTable; end
        class Bar < Foo; end;
      end
      Booga::Foo.send(:include, Blazy::Extensions::ActiveRecord::Fixnum)
    end

    after(:each) do
      remove_constants(:Booga)
    end

    def klass; Booga::Bar; end;
    def model; "bar"; end;
    def models; "bars"; end;

    it_should_behave_like "FixnumExtension"
   end
end