require File.dirname(__FILE__) + '/../../spec_helper'

describe "Scope Merge" do
  describe "when included" do
    before(:each) do
      ActiveRecord::Base.named_scope :dummy_limit, lambda { |limit| {:limit => limit} }
    end

    it "should merge scopes of base class to existing inheritors" do
      project_1 = Factory(:project)
      project_2 = Factory(:project)
      project_3 = Factory(:project)

      ActiveRecord::Base.send(:include, Blazy::Extensions::ActiveRecord::ScopeMerge)

      Project.dummy_limit(2).collect(&:id).should == [project_1.id, project_2.id]
    end

    after(:each) do
      ActiveRecord::Base.scopes.delete :dummy_limit
      Project.scopes.delete :dummy_limit
    end
  end
end
