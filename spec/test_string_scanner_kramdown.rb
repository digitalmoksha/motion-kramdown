# -*- coding: utf-8 -*-

describe Kramdown::Utils::StringScanner do

  [
    ["...........X............", [/X/], 1],
    ["1\n2\n3\n4\n5\n6X", [/X/], 6],
    ["1\n2\n3\n4\n5\n6X\n7\n8X", [/X/,/X/], 8],
    [(".\n" * 1000) + 'X', [/X/], 1001]
  ].each_with_index do |test_data, i|
    test_string, scan_regexes, line_number = test_data
    it "computes the correct current_line_number for example ##{i+1}" do
      str_sc = Kramdown::Utils::StringScanner.new(test_string)
      scan_regexes.each { |scan_re| str_sc.scan_until(scan_re) }
      expect(str_sc.current_line_number).to eq line_number
    end
  end

end
