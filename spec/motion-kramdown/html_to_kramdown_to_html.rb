describe "html-to-kramdown-to-html conversion" do

  `tidy -v 2>&1`
  if $?.exitstatus != 0
    warn("Skipping html-to-kramdown-to-html tests because tidy executable is missing")
  else
    EXCLUDE_HTML_KD_FILES = [
      'test/testcases/span/extension/options.html',                     # bc of parse_span_html option
      'test/testcases/span/05_html/normal.html',                        # bc of br tag before closing p tag
      'test/testcases/block/12_extension/nomarkdown.html',              # bc of nomarkdown extension
      'test/testcases/block/09_html/simple.html',                       # bc of webgen:block elements
      'test/testcases/block/09_html/markdown_attr.html',                # bc of markdown attr
      'test/testcases/block/09_html/html_to_native/table_simple.html',  # bc of invalidly converted simple table
      'test/testcases/block/06_codeblock/whitespace.html',              # bc of entity to char conversion
      'test/testcases/block/06_codeblock/rouge/simple.html',            # bc of double surrounding <div>
      'test/testcases/block/11_ial/simple.html',                        # bc of change of ordering of attributes in header
      'test/testcases/span/03_codespan/highlighting.html',              # bc of span elements inside code element
      'test/testcases/block/04_header/with_auto_ids.html',              # bc of auto_ids=true option
      'test/testcases/block/04_header/header_type_offset.html',         # bc of header_offset option
      'test/testcases/block/16_toc/toc_exclude.html',                   # bc of different attribute ordering
      'test/testcases/span/autolinks/url_links.html',                   # bc of quot entity being converted to char
      ('test/testcases/span/03_codespan/rouge/simple.html' if RUBY_VERSION < '2.0'),
      'test/testcases/block/15_math/ritex.html',                        # bc of tidy
      'test/testcases/span/math/ritex.html',                            # bc of tidy
      'test/testcases/block/15_math/itex2mml.html',                     # bc of tidy
      'test/testcases/span/math/itex2mml.html',                         # bc of tidy
      'test/testcases/span/math/mathjaxnode.html',                      # bc of tidy
      'test/testcases/block/15_math/mathjax_preview.html',              # bc of mathjax preview
      'test/testcases/block/15_math/mathjax_preview_simple.html',       # bc of mathjax preview
      'test/testcases/span/01_link/link_defs_with_ial.html',            # bc of attribute ordering

      'testcases/block/15_math/gh_128.html',                            # bc no math support yet
      'test/testcases/block/15_math/normal.html',                       # bc no math support yet
      'test/testcases/span/math/normal.html',                           # bc no math support yet
      'test/testcases/span/05_html/mark_element.html',                  # bc of tidy
    ].compact

    Dir["#{focus_files(testcase_dir)}.{html,html.19}"].each do |html_file|
      next if EXCLUDE_HTML_KD_FILES.any? {|f| html_file =~ /#{f}(\.19)?$/}
      next if skip_file_ruby_19?(html_file)
      opts_file = html_file.sub(/\.html(\.19)?$/, '.options')

      it "#{short_name(html_file)} --> kramdown --> html" do
        kd      = Kramdown::Document.new(File.read(html_file), :input => 'html', :auto_ids => false, :footnote_nr => 1).to_kramdown
        options = load_options(opts_file)
        doc     = Kramdown::Document.new(kd, options)
        expect(tidy_output(File.read(html_file))).to eq tidy_output(doc.to_html)
      end
    end
  end
end