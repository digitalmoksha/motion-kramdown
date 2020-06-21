describe "kramdown-to-xxx conversion" do

  EXCLUDE_FILES = [
    'test/testcases/block/04_header/with_auto_ids.text',          # bc no transliteration support yet
    'test/testcases/block/06_codeblock/highlighting-opts.text',   # bc no highlight support yet
    'test/testcases/block/06_codeblock/rouge/highlighting-rouge.text',  # bc no highlight support yet
    'test/testcases/block/06_codeblock/highlighting.text',        # bc no highlight support yet
    'test/testcases/block/06_codeblock/highlighting-minted.text', # bc no highlight support yet
    'test/testcases/block/06_codeblock/highlighting-minted-with-opts.text', # bc no highlight support yet
    'test/testcases/block/12_extension/options3.text',            # bc no highlight support yet
    'test/testcases/block/15_math/gh_128.text',                   # bc no math support yet
    'test/testcases/block/15_math/itex2mml.text',                 # bc no math support yet
    'test/testcases/block/15_math/normal.text',                   # bc no math support yet
    'test/testcases/block/15_math/ritex.text',                    # bc no math support yet
    'test/testcases/block/15_math/mathjax_preview.text',          # bc no math support yet
    'test/testcases/block/15_math/mathjax_preview_simple.text',   # bc no math support yet
    'test/testcases/block/15_math/mathjaxnode_notexhints.text',       # bc no math support yet
    'test/testcases/block/15_math/mathjaxnode_semantics.text',        # bc no math support yet
    'test/testcases/block/15_math/mathjaxnode.text',                  # bc no math support yet

    'test/testcases/span/math/itex2mml.text',                     # bc no math support yet
    'test/testcases/span/math/mathjaxnode.text',                  # bc no math support yet
    'test/testcases/span/math/normal.text',                       # bc no math support yet
    'test/testcases/span/math/ritex.text',                        # bc no math support yet
    'test/testcases/span/03_codespan/rouge/highlighting-rouge.text',    # bc no highlight support yet
    'test/testcases/span/03_codespan/highlighting.text',          # bc no highlight support yet
    'test/testcases/span/03_codespan/highlighting-minted.text',   # bc no highlight support yet
  ].compact

  Dir["#{focus_files(testcase_dir)}.text"].each do |text_file|
    next if EXCLUDE_FILES.any? {|f| text_file =~ /#{f}$/}
    base_name   = text_file.sub(/\.text$/, '')
    html_file   = text_file.sub('.text', '.html')
    opts_file   = text_file.sub(/\.text$/, '.options')

    (Dir[base_name + ".*"] - [text_file, opts_file]).each do |output_file|
      output_format = convert_to_format(output_file)
      next unless converter_supported?(output_format)
      next if skip_file_ruby_19?(output_file)

      it "#{short_name(text_file)} --> #{output_format}" do
        options   = load_options(opts_file)
        doc       = Kramdown::Document.new(File.read(text_file), options)
        expect(doc.send("to_#{output_format}")).to eq File.read(output_file)
      end
    end
  end

end

