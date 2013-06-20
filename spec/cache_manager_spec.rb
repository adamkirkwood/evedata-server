require 'helper'

describe EveData::CacheManager do

  before :each do
    @cache = EveData::CacheManager.new
  end

  describe ".create_key" do
    
    context "endpoint WITHOUT ID" do
      it "creates a key from given query params" do
        key = @cache.create_key("/celestials?type=6&limit=5&&page=10")
    
        expect(key).to eq("celestials:limit:5:page:10:type:6")
      end
    end
    
    context "endpoint WITH ID" do
      it "creates a key from given query params" do
        key = @cache.create_key("/celestials/1234567")
    
        expect(key).to eq("celestials:1234567")
      end
    end
    
  end

end