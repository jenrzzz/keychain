module CF
  typedef :pointer, :cfdataref

  attach_function 'CFDataCreate', [:pointer, :buffer_in, :cfindex], :cfdataref  
  attach_function 'CFDataGetLength', [:cfdataref], :cfindex  
  attach_function 'CFDataGetBytePtr', [:cfdataref], :pointer

  class Data < Base
    register_type("CFData")
    def self.from_string(s)
      wrap(CF.CFDataCreate(nil, s, s.bytesize))
    end

    def to_s
      ptr = CF.CFDataGetBytePtr(self)
      ptr.read_string(CF.CFDataGetLength(self)).force_encoding(Encoding::ASCII_8BIT)
    end
  end
end

