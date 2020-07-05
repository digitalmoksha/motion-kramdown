# -*- coding: utf-8 -*-
#
#--
# Copyright (C) 2009-2016 Thomas Leitner <t_leitner@gmx.at>
#
# This file is part of kramdown which is licensed under the MIT.
#++
#

require 'kramdown/utils'

module Kramdown

  # This module contains all available converters, i.e. classes that take a root Element and convert
  # it to a specific output format. The result is normally a string. For example, the
  # Converter::Html module converts an element tree into valid HTML.
  #
  # Converters use the Base class for common functionality (like applying a template to the output)
  # \- see its API documentation for how to create a custom converter class.
  module Converter

    # RM autoload :Base, 'kramdown/converter/base'
    # RM autoload :Html, 'kramdown/converter/html'
    # RM autoload :Latex, 'kramdown/converter/latex'
    # RM autoload :Kramdown, 'kramdown/converter/kramdown'
    # RM autoload :Toc, 'kramdown/converter/toc'
    # RM autoload :RemoveHtmlTags, 'kramdown/converter/remove_html_tags'
    # RM autoload :Pdf, 'kramdown/converter/pdf'
    # RM autoload :HashAST, 'kramdown/converter/hash_ast'
    # RM autoload :Man, 'kramdown/converter/man'

    extend ::Kramdown::Utils::Configurable

    configurable(:syntax_highlighter)

    # RM ["Minted", "Coderay", "Rouge"].each do |klass_name|
    # RM   kn_down = klass_name.downcase.intern
    # RM   add_syntax_highlighter(kn_down) do |converter, text, lang, type, opts|
    # RM     require "kramdown/converter/syntax_highlighter/#{kn_down}"
    # RM     klass = ::Kramdown::Utils.deep_const_get("::Kramdown::Converter::SyntaxHighlighter::#{klass_name}")
    # RM.    if !klass.const_defined?(:AVAILABLE) || klass::AVAILABLE
    # RM       add_syntax_highlighter(kn_down, klass)
    # RM     else
    # RM       add_syntax_highlighter(kn_down) {|*args| nil}
    # RM     end
    # RM     syntax_highlighter(kn_down).call(converter, text, lang, type, opts)
    # RM   end
    # RM end
    # RM
    # RM configurable(:math_engine)
    # RM
    # RM ['Mathjax', "MathjaxNode", "SsKaTeX", "Ritex", "Itex2MML"].each do |klass_name|
    # RM   kn_down = klass_name.downcase.intern
    # RM   add_math_engine(kn_down) do |converter, el, opts|
    # RM     require "kramdown/converter/math_engine/#{kn_down}"
    # RM     klass = ::Kramdown::Utils.deep_const_get("::Kramdown::Converter::MathEngine::#{klass_name}")
    # RM     if !klass.const_defined?(:AVAILABLE) || klass::AVAILABLE
    # RM       add_math_engine(kn_down, klass)
    # RM     else
    # RM       add_math_engine(kn_down) {|*args| nil}
    # RM     end
    # RM     math_engine(kn_down).call(converter, el, opts)
    # RM   end
    # RM end

  end

end
