require 'spec_helper'

describe Blazy do
  describe "init" do
    it "should load all rails models" do
      Rails.expects(:load_all_models)

      Blazy.init
    end
  end
end
