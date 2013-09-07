require 'helper'

describe "blueprints - endpoint" do

  describe "/blueprints" do
    
    context "search endpoint WITHOUT PARAMS" do
      it "returns 25 blueprints" do
        get('/blueprints')
      end
    end
    
    context "search endpoint WITH ID" do
      it "returns JSON for the blueprint"
    end
    
  end
  
  describe "/blueprints/:id" do
    context "with VALID ID" do
      it "returns JSON for the blueprint"
    end
    
    context "with INVALID ID" do
      it "returns an empty Array"
    end
  end
  
  describe "/blueprints/:id/requirements" do
    context "with VALID ID" do
      it "returns JSON for the blueprints requirements"
    end
    
    context "with INVALID ID" do
      it "returns an empty Array"
    end
    
    context "search by activity_id" do
      it "shows only requirements with the supplied activity_id"
    end
  end

end
