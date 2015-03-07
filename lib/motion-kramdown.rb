unless defined?(Motion::Project::Config)
  raise 'The motion-kramdown gem must be required within a RubyMotion project Rakefile.'
end

require 'motion-strscan'
require 'motion-yaml'

Motion::Project::App.setup do |app|
  # scans app.files until it finds app/ (the default)
  # if found, it inserts just before those files, otherwise it will insert to
  # the end of the list
  insert_point = app.files.find_index { |file| file =~ /^(?:\.\/)?app\// } || 0

  # We need the files to be compiled in a top down fashion:
  #  `parser/kramdown.rb` before `parser/kramdown/autolink.rb`
  # as an example, due to dependencies
  lib_dir = File.expand_path(File.dirname(__FILE__))
  excluded_files = ["#{lib_dir}/kramdown/converter/pdf.rb",
                    "#{lib_dir}/kramdown/converter/pdf.rb",
                    "#{lib_dir}/kramdown/converter/math_engine/itex2mml.rb",
                    "#{lib_dir}/kramdown/converter/math_engine/mathjax.rb",
                    "#{lib_dir}/kramdown/converter/math_engine/ritex.rb",
                    "#{lib_dir}/kramdown/converter/syntax_highlighter/coderay.rb",
                    "#{lib_dir}/kramdown/converter/syntax_highlighter/rouge.rb",
                  ]
  Dir.glob(File.join(lib_dir, 'kramdown', '**/*.rb')).each do |file|
    unless excluded_files.include?(file)
      app.files.insert(insert_point, file)
    end
  end
  Dir.glob(File.join(lib_dir, 'rubymotion', '**/*.rb')).each do |file|
    app.files.insert(insert_point, file)
  end
  
  app.files_dependencies(
      "#{lib_dir}/kramdown/parser/kramdown/html.rb"       => "#{lib_dir}/kramdown/parser/html.rb",
      "#{lib_dir}/kramdown/parser/kramdown/paragraph.rb"  => "#{lib_dir}/kramdown/parser/html.rb",
      "#{lib_dir}/kramdown/parser/kramdown/paragraph.rb"  => "#{lib_dir}/kramdown/parser/kramdown/list.rb",
      "#{lib_dir}/kramdown/parser/kramdown/footnote.rb"   => "#{lib_dir}/kramdown/parser/kramdown/codeblock.rb",
      "#{lib_dir}/kramdown/parser/markdown.rb"            => "#{lib_dir}/kramdown/parser/kramdown/paragraph.rb",
      "#{lib_dir}/kramdown/converter/html.rb"             => "#{lib_dir}/kramdown/converter/base.rb",
      "#{lib_dir}/kramdown/converter/kramdown.rb"         => "#{lib_dir}/kramdown/converter/base.rb",
      "#{lib_dir}/kramdown/converter/remove_html_tags.rb" => "#{lib_dir}/kramdown/converter/base.rb",
      "#{lib_dir}/kramdown/converter/toc.rb"              => "#{lib_dir}/kramdown/converter/base.rb",
      "#{lib_dir}/kramdown/converter/latex.rb"            => "#{lib_dir}/kramdown/converter/base.rb"
  )
end
