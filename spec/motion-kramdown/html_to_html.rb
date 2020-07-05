describe "html-to-{html,kramdown} conversion" do

  `tidy -v 2>&1`
  if $?.exitstatus != 0
    warn("Skipping html-to-{html,kramdown} tests because tidy executable is missing")
  else
    EXCLUDE_HTML_FILES = [
      'test/testcases/block/04_header/with_auto_ids.html',          # bc of auto_ids=true option
      'test/testcases/block/04_header/header_type_offset.html',     # bc of header_offset option
      'test/testcases/block/06_codeblock/whitespace.html',          # bc of span inside pre
      'test/testcases/block/06_codeblock/rouge/simple.html',        # bc of double surrounding <div>
      'test/testcases/block/06_codeblock/rouge/multiple.html',      # bc of double surrounding <div>
      'test/testcases/block/09_html/simple.html',                   # bc of xml elements
      'test/testcases/block/09_html/xml.html',                      # bc of tidy
      'test/testcases/block/15_math/ritex.html',                    # bc of tidy
      'test/testcases/block/15_math/itex2mml.html',                 # bc of tidy
      'test/testcases/block/15_math/mathjax_preview.html',          # bc of mathjax preview
      'test/testcases/block/15_math/mathjax_preview_simple.html',   # bc of mathjax preview
      'test/testcases/block/15_math/mathjax_preview_as_code.html',  # bc no math support yet
      'test/testcases/block/15_math/gh_128.html',                   # bc no math support yet
      'test/testcases/block/15_math/normal.html',                   # bc no math support yet

      'test/testcases/span/03_codespan/highlighting.html',          # bc of span elements inside code element
      ('test/testcases/span/03_codespan/rouge/simple.html'    if RUBY_VERSION < '2.0'),
      'test/testcases/span/05_html/mark_element.html',              # bc of tidy
      'test/testcases/span/05_html/xml.html',                       # bc of tidy
      'test/testcases/span/math/ritex.html',                        # bc of tidy
      'test/testcases/span/math/itex2mml.html',                     # bc of tidy
      'test/testcases/span/math/normal.html',                       # bc no math support yet

      'test/testcases/block/16_toc/toc_with_footnotes.html',       # bc of issue with nbsp
      'test/testcases/block/12_extension/options.html',            # bc of issue with nbsp
      'test/testcases/block/12_extension/options2.html',           # bc of issue with nbsp
      'test/testcases/span/04_footnote/footnote_nr.html',          # bc of issue with nbsp
      'test/testcases/span/04_footnote/inside_footnote.html',      # bc of issue with nbsp
      'test/testcases/span/04_footnote/backlink_text.html',        # bc of issue with nbsp
      'test/testcases/span/abbreviations/in_footnote.html',        # bc of issue with nbsp

      'test/testcases/span/math/sskatex.html',                     # bc of tidy
      'test/testcases/block/15_math/sskatex.html',                 # bc of tidy

      'test/testcases/span/04_footnote/backlink_inline.html',      # bc no math support yet
    ].compact

    EXCLUDE_HTML_TEXT_FILES = ['test/testcases/block/09_html/parse_as_span.htmlinput',
                               'test/testcases/block/09_html/parse_as_raw.htmlinput',
                              ].compact

    Dir["#{focus_files(testcase_dir)}.{html,html.19,htmlinput,htmlinput.19}"].each do |html_file|
      next if EXCLUDE_HTML_FILES.any? {|f| html_file =~ /#{f}(\.19)?$/}
      next if skip_file_ruby_19?(html_file)

      opts_file = html_file.sub(/\.html(input)?(\.19)?$/, '.options')

      out_files = []
      out_files << [(html_file =~ /\.htmlinput(\.19)?$/ ? html_file.sub(/input(\.19)?$/, '') : html_file), :to_html]
      if html_file =~ /\.htmlinput(\.19)?$/ && !EXCLUDE_HTML_TEXT_FILES.any? {|f| html_file =~ /#{f}/}
        out_files << [html_file.sub(/htmlinput(\.19)?$/, 'text'), :to_kramdown]
      end

      out_files.select {|f, _| File.exist?(f)}.each do |out_file, out_method|

        it "#{short_name(html_file)} --> #{File.extname(out_file)}" do
          options   = load_options(opts_file)
          doc       = Kramdown::Document.new(File.read(html_file), options.merge(:input => 'html'))
          if out_method == :to_html
            expect(tidy_output(File.read(out_file))).to eq tidy_output(doc.send(out_method))
          else
            expect(File.read(out_file)).to eq doc.send(out_method)
          end
        end
      end
    end
  end

end