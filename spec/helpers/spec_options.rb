# Add following abilities
#
#   rake spec filter="name of spec"                   # To filter by spec name
#   rake spec files=foo_spec filter="name of spec"
#   rake spec filter_context="this doesn't work yet"  # To filter by context name (doesn't work until MacBacon implements it)
#   rake spec hide_backtraces=yes                     # Hide backtraces
#   rake spec focus=block/03_paragraph                # Focus on only certain testcase files


# From http://chen.do/blog/2013/06/03/running-individual-specs-with-rubymotion/
#------------------------------------------------------------------------------
def silence_warnings(&block)
  warn_level = $VERBOSE
  $VERBOSE = nil
  begin
    result = block.call
  ensure
    $VERBOSE = warn_level
  end
  result
end

silence_warnings do
  module Bacon
    if ENV['filter']
      $stderr.puts "Filtering specs that match: #{ENV['filter']}"
      RestrictName = Regexp.new(ENV['filter'])
    end

    if ENV['filter_context']
      $stderr.puts "Filtering contexts that match: #{ENV['filter_context']}"
      RestrictContext = Regexp.new(ENV['filter_context'])
    end

    Backtraces = false if ENV['hide_backtraces']
  end
end