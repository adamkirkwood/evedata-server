require 'helper'

describe "blueprints - endpoint" do

  describe "/blueprints" do
    
    context "search WITHOUT PARAMS" do
      it "returns 25 blueprints" do
        get '/blueprints'
        expect(last_response).to be_ok
        expect(last_response.body).to be_a(Array)
      end
    end
    
    context "search WITH ID" do
      it "returns JSON for the blueprint" do
      	get '/'
      	expect(last_response).to be_ok
      end
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
