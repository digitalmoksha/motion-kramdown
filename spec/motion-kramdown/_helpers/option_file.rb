#------------------------------------------------------------------------------
def testcase_dir(dir = 'testcases')
  File.join(File.dirname(__FILE__), '../../../test', dir)
end

#------------------------------------------------------------------------------
def focus_files(dir)
  focus = ENV["focus"] ? File.join(dir, ENV["focus"]) : dir
  File.directory?(focus) ? File.join(focus, '**/*') : "#{focus}"
end

#------------------------------------------------------------------------------
def load_options(opts_file)
  opts_file = File.join(File.dirname(opts_file), 'options') if !File.exist?(opts_file)
  options   = File.exist?(opts_file) ? YAML::load(File.read(opts_file)) : {:auto_ids => false, :footnote_nr => 1}

  # change {":autoids" => false} to {:autoids => false}
  options.tap do |o|
    o.keys.each { |k| o[(k.to_s[0] == ':' ? k[1..-1] : k).to_sym] = o.delete(k) }
  end

  # YAML isn't hanldling integers correctly, is giving doubles instead
  options[:header_offset] = options[:header_offset].to_int  if options[:header_offset]
  options[:footnote_nr]   = options[:footnote_nr].to_int    if options[:footnote_nr]
  options
end

#------------------------------------------------------------------------------
def short_name(text_file)
  text_file.split(File.join(File.dirname(__FILE__), '../../test') + '/').last
end

#------------------------------------------------------------------------------
def convert_to_format(file)
  File.extname(file.sub(/\.19$/, ''))[1..-1]
end

#------------------------------------------------------------------------------
def converter_supported?(format)
  Kramdown::Converter.const_defined?(format[0..0].upcase + format[1..-1])
end

#------------------------------------------------------------------------------
def skip_file_ruby_19?(file)
  (RUBY_VERSION >= '1.9' && File.exist?(file + '.19')) || (RUBY_VERSION < '1.9' && file =~ /\.19$/)
end