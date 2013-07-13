require 'snappy'

module EveData
  class Compressor
    def self.inflate(value)
      Snappy.inflate value
    rescue
      value
    end
    
    def self.deflate(value)
      Snappy.deflate value
    rescue
      value
    end
  end
end