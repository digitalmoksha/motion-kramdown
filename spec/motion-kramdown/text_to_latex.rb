#--- Latex conversion is currently not supported

# describe "text-to-latex conversion" do
#
#   `latex -v 2>&1`
#   if $?.exitstatus != 0
#     warn("Skipping latex compilation tests because latex executable is missing")
#   else
#     EXCLUDE_LATEX_FILES = [
#       'test/testcases/span/01_link/image_in_a.text', # bc of image link
#       'test/testcases/span/01_link/imagelinks.text', # bc of image links
#       'test/testcases/span/04_footnote/markers.text', # bc of footnote in header
#     ].compact
#
#     Dir["#{focus_files(testcase_dir)}.text"].each do |text_file|
#       next if EXCLUDE_LATEX_FILES.any? {|f| text_file =~ /#{f}$/}
#
#       it "#{short_name(text_file)} --> latex compilation" do
#         latex =  Kramdown::Document.new(File.read(text_file),
#                                         :auto_ids => false, :footnote_nr => 1,
#                                         :template => 'document').to_latex
#         Dir.mktmpdir do |tmpdir|
#           result = IO.popen("latex -output-directory='#{tmpdir}' 2>/dev/null", 'r+') do |io|
#             io.write(latex)
#             io.close_write
#             io.read
#           end
#           expect($?.exitstatus == 0).to eq result.scan(/^!(.*\n.*)/).join("\n")
#         end
#       end
#     end
#   end
# end