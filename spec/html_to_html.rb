describe "html-to-html conversion" do

  `tidy -v 2>&1`
  if $?.exitstatus != 0
    warn("Skipping html-to-html tests because tidy executable is missing")
  else
    EXCLUDE_HTML_FILES = [
      'test/testcases/block/06_codeblock/whitespace.html',          # bc of span inside pre
      'test/testcases/block/09_html/simple.html',                   # bc of xml elements
      'test/testcases/span/03_codespan/highlighting.html',          # bc of span elements inside code element
      'test/testcases/block/04_header/with_auto_ids.html',          # bc of auto_ids=true option
      'test/testcases/block/04_header/header_type_offset.html',     # bc of header_offset option
      'test/testcases/block/06_codeblock/highlighting-rouge.html',  # bc of double surrounding <div>
      ('test/testcases/span/03_codespan/highlighting-rouge.html'    if RUBY_VERSION < '2.0'),
      'test/testcases/block/15_math/ritex.html',                    # bc of tidy
      'test/testcases/span/math/ritex.html',                        # bc of tidy
      'test/testcases/block/15_math/itex2mml.html',                 # bc of tidy
      'test/testcases/span/math/itex2mml.html',                     # bc of tidy

      'test/testcases/block/15_math/gh_128.html',                   # bc no math support yet
      'test/testcases/block/15_math/normal.html',                   # bc no math support yet
      'test/testcases/span/math/normal.html',                       # bc no math support yet
    ]

    Dir["#{focus_files(testcase_dir)}.{html,html.19,htmlinput,htmlinput.19}"].each do |html_file|
      next if EXCLUDE_HTML_FILES.any? {|f| html_file =~ /#{f}(\.19)?$/}
      next if skip_file_ruby_19?(html_file)

      out_file  = (html_file =~ /\.htmlinput(\.19)?$/ ? html_file.sub(/input(\.19)?$/, '') : html_file)
      opts_file = html_file.sub(/\.html(input)?(\.19)?$/, '.options')
      
      it "#{short_name(html_file)} --> html" do
        options   = load_options(opts_file)
        doc       = Kramdown::Document.new(File.read(html_file), options.merge(:input => 'html'))
        expect(tidy_output(File.read(out_file))).to eq tidy_output(doc.to_html)
      end
    end
  end

end