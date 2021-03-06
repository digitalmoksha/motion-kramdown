describe "gfm-to-html conversion" do

  MATHJAX_NODE_AVAILABLE = begin
                             require 'kramdown/converter/math_engine/mathjaxnode'
                             Kramdown::Converter::MathEngine::MathjaxNode::AVAILABLE or
                               warn("Skipping MathjaxNode tests as MathjaxNode is not available")
                           end

  KATEX_AVAILABLE = begin
                      / class="katex"/ === Kramdown::Document.
                        new('$$a$$', {:math_engine => :sskatex}).to_html or
                        warn("Skipping SsKaTeX tests as SsKaTeX is not available.")
                    rescue
                      warn("Skipping SsKaTeX tests as default SsKaTeX config does not work.")
                    end or warn("Run \"rake dev:test_sskatex_deps\" to see why.")

  EXCLUDE_GFM_FILES = [
   'test/testcases/block/03_paragraph/no_newline_at_end.text',
   'test/testcases/block/03_paragraph/indented.text',
   'test/testcases/block/03_paragraph/two_para.text',
   'test/testcases/block/03_paragraph/line_break_last_line.text',
   'test/testcases/block/04_header/atx_header.text',
   'test/testcases/block/04_header/setext_header.text',
   'test/testcases/block/04_header/with_auto_ids.text', # bc of ID generation difference
   'test/testcases/block/04_header/with_auto_id_prefix.text', # bc of ID generation difference
   'test/testcases/block/05_blockquote/indented.text',
   'test/testcases/block/05_blockquote/lazy.text',
   'test/testcases/block/05_blockquote/nested.text',
   'test/testcases/block/05_blockquote/no_newline_at_end.text',
   'test/testcases/block/06_codeblock/error.text',
   'test/testcases/block/06_codeblock/highlighting-opts.text',   # bc no highlight support yet
   'test/testcases/block/06_codeblock/highlighting.text',        # bc no highlight support yet
   ('test/testcases/block/06_codeblock/rouge/simple.text' if RUBY_VERSION < '2.0'), #bc of rouge
   ('test/testcases/block/06_codeblock/rouge/multiple.text' if RUBY_VERSION < '2.0'), #bc of rouge
   'test/testcases/block/07_horizontal_rule/error.text',
   'test/testcases/block/08_list/escaping.text',
   'test/testcases/block/08_list/item_ial.text',
   'test/testcases/block/08_list/lazy.text',
   'test/testcases/block/08_list/lazy_and_nested.text', # bc of change in lazy line handling
   'test/testcases/block/08_list/list_and_others.text',
   'test/testcases/block/08_list/other_first_element.text',
   'test/testcases/block/08_list/simple_ul.text',
   'test/testcases/block/08_list/special_cases.text',
   'test/testcases/block/09_html/comment.text',
   'test/testcases/block/09_html/html_to_native/code.text',
   'test/testcases/block/09_html/html_to_native/emphasis.text',
   'test/testcases/block/09_html/html_to_native/typography.text',
   'test/testcases/block/09_html/parse_as_raw.text',
   'test/testcases/block/09_html/simple.text',
   'test/testcases/block/12_extension/comment.text',
   'test/testcases/block/12_extension/ignored.text',
   'test/testcases/block/12_extension/nomarkdown.text',
   'test/testcases/block/12_extension/options3.text',            # bc no highlight support yet
   'test/testcases/block/13_definition_list/item_ial.text',
   'test/testcases/block/13_definition_list/multiple_terms.text',
   'test/testcases/block/13_definition_list/no_def_list.text',
   'test/testcases/block/13_definition_list/simple.text',
   'test/testcases/block/13_definition_list/with_blocks.text',
   'test/testcases/block/14_table/errors.text',
   'test/testcases/block/14_table/escaping.text',
   'test/testcases/block/14_table/simple.text',
   'test/testcases/block/15_math/normal.text',
   'test/testcases/block/15_math/mathjaxnode_notexhints.text',
   'test/testcases/block/15_math/mathjaxnode_semantics.text',
   'test/testcases/block/15_math/mathjaxnode.text',
   'test/testcases/block/15_math/gh_128.text',                   # bc no math support yet
   'test/testcases/block/15_math/itex2mml.text',                 # bc no math support yet
   'test/testcases/block/15_math/normal.text',                   # bc no math support yet
   'test/testcases/block/15_math/ritex.text',                    # bc no math support yet
   'test/testcases/block/15_math/mathjax_preview.text',          # bc no math support yet
   'test/testcases/block/15_math/mathjax_preview_simple.text',   # bc no math support yet
   'test/testcases/block/15_math/mathjax_preview_as_code.text',  # bc no math support yet
   'test/testcases/block/16_toc/toc_with_footnotes.text',        # bc of ID generation difference

   'test/testcases/encoding.text',

   'test/testcases/span/01_link/inline.text',
   'test/testcases/span/01_link/link_defs.text',
   'test/testcases/span/01_link/reference.text',
   'test/testcases/span/02_emphasis/normal.text',
   'test/testcases/span/03_codespan/normal.text',
   'test/testcases/span/03_codespan/rouge/simple.text',    # bc no highlight support yet
   'test/testcases/span/03_codespan/highlighting.text',          # bc no highlight support yet
   'test/testcases/span/03_codespan/rouge/simple.text',
   'test/testcases/span/03_codespan/rouge/multiple.text',
   'test/testcases/span/04_footnote/definitions.text',
   'test/testcases/span/04_footnote/markers.text',
   'test/testcases/span/05_html/across_lines.text',
   'test/testcases/span/05_html/markdown_attr.text',
   'test/testcases/span/05_html/normal.text',
   'test/testcases/span/05_html/raw_span_elements.text',
   'test/testcases/span/autolinks/url_links.text',
   'test/testcases/span/extension/comment.text',
   'test/testcases/span/ial/simple.text',
   'test/testcases/span/line_breaks/normal.text',
   'test/testcases/span/math/itex2mml.text',                     # bc no math support yet
   'test/testcases/span/math/mathjaxnode.text',                  # bc no math support yet
   'test/testcases/span/math/normal.text',                       # bc no math support yet
   'test/testcases/span/math/ritex.text',                        # bc no math support yet
   'test/testcases/span/text_substitutions/entities_as_char.text',
   'test/testcases/span/text_substitutions/entities.text',
   'test/testcases/span/text_substitutions/typography.text',

   'test/testcases_gfm/backticks_syntax.text',                   # bc no highlight support yet
   'test/testcases_gfm/header_ids.text',                         # bc no math support yet

   ('test/testcases/block/15_math/sskatex.text' unless KATEX_AVAILABLE),
   ('test/testcases/span/math/sskatex.text' unless KATEX_AVAILABLE),

   'test/testcases/span/04_footnote/backlink_inline.text',       # bc no math support yet
  ].compact

  ['testcases', 'testcases_gfm'].each do |item|
    Dir["#{focus_files(testcase_dir(item))}.text"].each do |text_file|
      next if EXCLUDE_GFM_FILES.any? {|f| text_file =~ /#{f}$/}
      basename  = text_file.sub(/\.text$/, '')
      opts_file = basename + '.options'

      html_file = [(".html.19" if RUBY_VERSION >= '1.9'), ".html"].compact.
        map {|ext| basename + ext }.
        detect {|file| File.exist?(file) }
      next unless html_file

      it "gfm #{short_name(text_file)} --> html" do
        options   = load_options(opts_file)
        doc       = Kramdown::Document.new(File.read(text_file), options.merge(:input => 'GFM'))
        expect(File.read(html_file)).to eq doc.to_html
      end
    end
  end
end
