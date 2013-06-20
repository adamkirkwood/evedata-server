require 'helper'

describe EveData::CacheManager do

  before :each do
    @cache = EveData::CacheManager.new
  end

  describe ".create_key" do
    it "creates a key from given query params" do
      cm = @cache.create_key("/celestials?type=6&limit=5&&page=10")
    
      expect(cm).to eq("celestials:limit:5:page:10:type:6")
    end
  end

end