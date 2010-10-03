require File.dirname(__FILE__) + '/../spec_helper'

describe Class do
  describe "class name" do
    after(:each) do
      remove_constants(:Foo)
    end

    it "should be full name for class in default namespace" do
      Class.class_name.should == "Class"
    end

    it "should be name of class without module name for class not in default namespace" do
      module Foo; class Bar; end; end;
      Foo::Bar.class_name.should == "Bar"
    end
  end
end
