require File.dirname(__FILE__) + '/../spec_helper'

describe "ActiveModel" do
  describe "-id" do
    it "should find model with id" do
       Factory(:project, :id => 007)

       project = Project-007

       project.should_not be_nil
       project.id.should be(007)
    end
  end
end