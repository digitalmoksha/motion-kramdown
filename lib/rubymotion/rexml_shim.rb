# REXML doesn't currently play well with RubyMotion, and we only need these
# constants, not the actual parser
#------------------------------------------------------------------------------
module REXML
  module Parsers
    class BaseParser
      LETTER = '[:alpha:]'
      DIGIT = '[:digit:]'

      COMBININGCHAR = '' # TODO
      EXTENDER = ''      # TODO

      NCNAME_STR= "[#{LETTER}_:][-[:alnum:]._:#{COMBININGCHAR}#{EXTENDER}]*"
      NAME_STR= "(?:(#{NCNAME_STR}):)?(#{NCNAME_STR})"
      UNAME_STR= "(?:#{NCNAME_STR}:)?#{NCNAME_STR}"

      NAMECHAR = '[\-\w\.:]'
      NAME = "([\\w:]#{NAMECHAR}*)"
      NMTOKEN = "(?:#{NAMECHAR})+"
      NMTOKENS = "#{NMTOKEN}(\\s+#{NMTOKEN})*"
      REFERENCE = "&(?:#{NAME};|#\\d+;|#x[0-9a-fA-F]+;)"
      REFERENCE_RE = /#{REFERENCE}/
    end
  end
end