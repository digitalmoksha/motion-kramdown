describe "asserting that converters don't modify the document tree" do

  EXCLUDE_PDF_MODIFY = ['test/testcases/span/text_substitutions/entities.text',
                        'test/testcases/span/text_substitutions/entities_numeric.text',
                        'test/testcases/span/text_substitutions/entities_as_char.text',
                        'test/testcases/span/text_substitutions/entities_as_input.text',
                        'test/testcases/span/text_substitutions/entities_symbolic.text',
                        'test/testcases/block/04_header/with_auto_ids.text',
                       ].compact

  EXCLUDE_TREE_FILES = [
    'test/testcases/block/15_math/gh_128.text',                       # bc no math support yet
    'test/testcases/block/15_math/itex2mml.text',                     # bc no math support yet
    'test/testcases/block/15_math/normal.text',                       # bc no math support yet
    'test/testcases/block/15_math/ritex.text',                        # bc no math support yet
    'test/testcases/block/15_math/mathjax_preview.text',              # bc no math support yet
    'test/testcases/block/15_math/mathjax_preview_simple.text',       # bc no math support yet
    'test/testcases/block/15_math/mathjaxnode_notexhints.text',       # bc no math support yet
    'test/testcases/block/15_math/mathjaxnode_semantics.text',        # bc no math support yet
    'test/testcases/block/15_math/mathjaxnode.text',                  # bc no math support yet
    'test/testcases/block/15_math/mathjax_preview_as_code.text',      # bc no math support yet
    'test/testcases/man/example.text',                                # bc no math support yet
    'test/testcases/span/math/mathjaxnode.text',                      # bc no math support yet
    'test/testcases/span/math/normal.text',                           # bc no math support yet
    'test/testcases/span/math/ritex.text',                            # bc no math support yet
    'test/testcases/span/math/itex2mml.text',                         # bc no math support yet
  ].compact

  Dir["#{focus_files(testcase_dir)}.text"].each do |text_file|
    next if EXCLUDE_TREE_FILES.any? {|f| text_file =~ /#{f}$/}
    opts_file = text_file.sub(/\.text$/, '.options')
    options   = load_options(opts_file)

    (Kramdown::Converter.constants(true).map {|c| c.to_sym} - [:Latex, :Base, :RemoveHtmlTags, :MathEngine, :SyntaxHighlighter]).each do |conv_class|
      next if conv_class == :Pdf && (RUBY_VERSION < '2.0' || EXCLUDE_PDF_MODIFY.any? {|f| text_file =~ /#{f}$/})

      it "#{short_name(text_file)} --> #{conv_class} modifies tree with file?" do
        options         = load_options(opts_file)
        doc             = Kramdown::Document.new(File.read(text_file), options)
        options_before  = Marshal.load(Marshal.dump(doc.options))
        tree_before     = Marshal.load(Marshal.dump(doc.root))
        Kramdown::Converter.const_get(conv_class).convert(doc.root, doc.options)
        expect(options_before).to eq doc.options
        assert_tree_not_changed(tree_before, doc.root)
      end
    end
  end

  def assert_tree_not_changed(oldtree, newtree)
    expect(oldtree.type).to eq newtree.type   # type mismatch
    if oldtree.value.kind_of?(Kramdown::Element)
      assert_tree_not_changed(oldtree.value, newtree.value)
    else
      expect(oldtree.value).to eq newtree.value   # value mismatch
    end
    expect(oldtree.attr).to eq newtree.attr                         # attr mismatch
    # TODO bug in the Marshaling the options - expect(oldtree.options).to eq newtree.options                   # options mismatch
    expect(oldtree.children.length).to eq newtree.children.length   # children count mismatch

    oldtree.children.each_with_index do |child, index|
      assert_tree_not_changed(child, newtree.children[index])
    end
  end
end