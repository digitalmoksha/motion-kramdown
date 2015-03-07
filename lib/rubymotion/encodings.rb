# There are several issues in how ICU handles encoding between character sets.
# This file tries to provide small fixes to these behaviors
#------------------------------------------------------------------------------

# As of RubyMotion 3.5, the String.encode method will always gives a 
#
#   RuntimeError: this operation cannot be performed with encoding `UTF-8' 
#   because Apple's ICU does not support it
#
# However, String.force_encoding seems to work.  However, that would support
# unsafe conversions.  For now, most of our input is already properly encoded
# as utf-8, so there is no need to run the actual encode.  Check for this.
#------------------------------------------------------------------------------
class String
  #------------------------------------------------------------------------------
  alias_method :orig_encode, :encode
  def encode(encoding)
    return self.dup if self.encoding.to_s == encoding.to_s
    if self.encoding.to_s == 'US-ASCII' && encoding.to_s == 'UTF-8'
      self.dup.force_encoding('UTF-8')
    else
      orig_encode(encoding)
    end
  end

  #------------------------------------------------------------------------------
  alias_method :orig_encode!, :encode!
  def encode!(encoding)
    return self if self.encoding.to_s == encoding.to_s
    if self.encoding.to_s == 'US-ASCII' && encoding.to_s == 'UTF-8'
      self.force_encoding('UTF-8')
    else
      orig_encode!(encoding)
    end
  end
  
end
