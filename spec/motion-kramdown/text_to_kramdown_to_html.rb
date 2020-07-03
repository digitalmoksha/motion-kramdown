describe "text-to-kramdown-to-html conversion" do

  `tidy -v 2>&1`
  if $?.exitstatus != 0
    warn("Skipping text->kramdown->html tests because tidy executable is missing")
  else
    EXCLUDE_TEXT_FILES = [
      'test/testcases/block/04_header/header_type_offset.text',         # bc of header_offset being applied twice
      ('test/testcases/block/04_header/with_auto_ids.text' if RUBY_VERSION <= '1.8.6'), # bc of dep stringex not working
      'test/testcases/block/04_header/with_auto_ids.text',              # bc no transliteration support yet
      ('test/testcases/block/06_codeblock/rouge/simple.text' if RUBY_VERSION < '2.0'), #bc of rouge
      ('test/testcases/block/06_codeblock/rouge/multiple.text' if RUBY_VERSION < '2.0'), #bc of rouge
      'test/testcases/block/06_codeblock/highlighting-opts.text',       # bc no highlight support yet
      'test/testcases/block/06_codeblock/highlighting.text',            # bc no highlight support yet
      'test/testcases/block/09_html/content_model/tables.text',         # bc of parse_block_html option
      'test/testcases/block/09_html/html_to_native/header.text',        # bc of auto_ids option that interferes
      'test/testcases/block/09_html/html_to_native/table_simple.text',  # bc of tr style attr getting removed
      'test/testcases/block/09_html/markdown_attr.text',                # bc of markdown attr
      'test/testcases/block/09_html/simple.text',                       # bc of webgen:block elements
      'test/testcases/block/09_html/xml.text',                          # bc of tidy
      'test/testcases/block/11_ial/simple.text',                        # bc of change of ordering of attributes in header
      'test/testcases/block/12_extension/options.text',                 # bc of options option
      'test/testcases/block/12_extension/options3.text',                # bc of options option
      'test/testcases/block/15_math/itex2mml.text',                     # bc of tidy
      'test/testcases/block/15_math/ritex.text',                        # bc of tidy
      'test/testcases/block/15_math/gh_128.text',                       # bc no math support yet
      'test/testcases/block/15_math/normal.text',                       # bc no math support yet
      'test/testcases/block/15_math/mathjax_preview.text',              # bc no math support yet
      'test/testcases/block/15_math/mathjax_preview_simple.text',       # bc no math support yet
      'test/testcases/block/15_math/mathjax_preview_as_code.text',      # bc no math support yet
      'test/testcases/block/15_math/mathjaxnode_notexhints.text',       # bc no math support yet
      'test/testcases/block/15_math/mathjaxnode_semantics.text',        # bc no math support yet
      'test/testcases/block/15_math/mathjaxnode.text',                  # bc no math support yet

      'test/testcases/span/01_link/link_defs_with_ial.text',            # bc of attribute ordering
      'test/testcases/span/03_codespan/highlighting.text',              # bc no highlight support yet
      ('test/testcases/span/03_codespan/rouge/simple.text' if RUBY_VERSION < '2.0'),
      'test/testcases/span/05_html/markdown_attr.text',                 # bc of markdown attr
      'test/testcases/span/05_html/xml.text',                           # bc of tidy
      'test/testcases/span/extension/options.text',                     # bc of parse_span_html option
      'test/testcases/span/extension/comment.text',                     # bc of comment text modifications (can this be avoided?)
      'test/testcases/span/math/itex2mml.text',                         # bc of tidy
      'test/testcases/span/math/mathjaxnode.text',                      # bc no math support yet
      'test/testcases/span/math/normal.text',                           # bc no math support yet
      'test/testcases/span/math/ritex.text',                            # bc of tidy
     ].compact

    Dir["#{focus_files(testcase_dir)}.text"].each do |text_file|
      next if EXCLUDE_TEXT_FILES.any? {|f| text_file =~ /#{f}$/}
      html_file  = text_file.sub(/\.text$/, '.html')
      html_file += '.19' if RUBY_VERSION >= '1.9' && File.exist?(html_file + '.19')
      next unless File.exist?(html_file)
      opts_file = text_file.sub(/\.text$/, '.options')

      it "#{short_name(text_file)} --> kramdown --> html" do
        options = load_options(opts_file)
        kdtext  = Kramdown::Document.new(File.read(text_file), options).to_kramdown
        html    = Kramdown::Document.new(kdtext, options).to_html
        expect(tidy_output(File.read(html_file))).to eq tidy_output(html)
      end
    end
  end
end