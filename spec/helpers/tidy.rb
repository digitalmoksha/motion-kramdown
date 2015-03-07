def tidy_output(out)
  cmd = "tidy -q --doctype omit #{RUBY_VERSION >= '1.9' ? '-utf8' : '-raw'} 2>/dev/null"
  result = IO.popen(cmd, 'r+') do |io|
    io.write(out)
    io.close_write
    io.read
  end
  if $?.exitstatus == 2
    raise "Problem using tidy"
  end
  result
end
