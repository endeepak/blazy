require 'spec_helper'

describe Rails do
  describe "load_all_models" do
    it "should be true if models can be loaded" do
      Rails.stubs(:root).returns(File.dirname(__FILE__))

      Rails.load_all_models.should be_true
    end

    it "should be false if models can't be loaded" do
      Rails.stubs(:root).returns(nil)

      Rails.load_all_models.should be_false
    end
  end
end
