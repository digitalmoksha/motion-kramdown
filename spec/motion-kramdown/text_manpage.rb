describe "text-manpage conversion" do
  Dir["#{focus_files(testcase_dir('testcases/man'))}.text"].each do |text_file|
    man_file  = text_file.sub(/\.text$/, '.man')
    next unless File.exist?(man_file)

    it "#{short_name(text_file)} --> manpage" do
      doc =  Kramdown::Document.new(File.read(text_file))
      expect(File.read(man_file)).to eq doc.to_man
    end
  end
end