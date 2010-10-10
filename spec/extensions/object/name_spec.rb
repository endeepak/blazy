require File.dirname(__FILE__) + '/../../spec_helper'

describe "class" do
  describe "in default name space" do
    before(:each) do
      class Foo;end;
    end

    after(:each) do
      remove_constants(:Foo)
    end

    it "singular name should be lower cased name of class" do
      Foo.singular_name.should == "foo"
    end

    it "plural name should be plural of lower cased name of class" do
      Foo.plural_name.should == "foos"
    end
  end

  describe "not in default name space" do
    before(:each) do
      module Foo; class Bar; end; end;
    end

    after(:each) do
      remove_constants(:Foo)
    end

    it "singular name should be lower case name of class alone" do
      Foo::Bar.singular_name.should == "bar"
    end

    it "plural name should be plural lower case name of class alone" do
      Foo::Bar.plural_name.should == "bars"
    end
  end

  describe "with camel case name" do
    before(:each) do
      class FooBar; end;
    end

    after(:each) do
      remove_constants(:FooBar)
    end

    it "singular name should be lower case name of class with under score" do
      FooBar.singular_name.should == "foo_bar"
    end

    it "plural name should be plural of lower cased name of class with under score" do
      FooBar.plural_name.should == "foo_bars"
    end
  end
end
