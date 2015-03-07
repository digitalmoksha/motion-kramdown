# motion-kramdown

This is a light modification of the [kramdown](https://github.com/gettalong/kramdown) Markdown parser, for use with RubyMotion on iOS and OS X.

Currently implements: _kramdown_ 1.5

## Introduction

_kramdown_ is yet-another-markdown-parser but fast, pure Ruby, using a strict syntax definition and supporting several common extensions.

The syntax definition for the kramdown syntax can be found in **doc/syntax.page** (or online at <http://kramdown.gettalong.org/syntax.html>) and a quick reference is available in **doc/quickref.page** or online at <http://kramdown.gettalong.org/quickref.html>.

The _kramdown_ library is mainly written to support the kramdown-to-HTML conversion chain. However, due to its flexibility it supports other input and output formats as well. Here is a list of the supported formats:

* input formats: kramdown (a Markdown superset), Markdown, HTML
* output formats: HTML, kramdown (and LaTeX and PDF, though not in _motion-kramdown_)

All the documentation on the available input and output formats is available in the **doc/** directory and online at <http://kramdown.gettalong.org>.

## Installation

Add it to your project's `Gemfile`

	gem 'motion-kramdown'

Edit your `Rakefile` and add

	require 'motion-kramdown'

## Usage

_motion-kramdown_ uses the same api and options as _kramdown_

```ruby
Kramdown::Document.new(text).to_html
```

For detailed information on usage and options, see the [kramdown documentation](http://kramdown.gettalong.org/documentation.html).  The full kramdown RDoc documentation is available at <http://kramdown.gettalong.org/rdoc/>

## Supported Features

The entire kramdown api is supported, except where noted below.

### Missing Features

These items are currently not supported

1. transliterated header ids
2. math engines: MathJax, Ritex, and itex2MML
3. syntax highlighters: Coderay and Rouge
4. Latex
5. PDF
6. using template files or the :template option
7. Andriod support (will accept pull requests)

## Testing

Test files are located in the `spec` directory.  The `test` directory contains the original kramdown test and data files, which are used in the specs.

    #--- run the entire test suite
    rake spec

    #--- run just the kramdown converter tests
    rake spec files=kramdown_to_xxx

    #--- run test for specific data files
    rake spec files=kramdown_to_xxx focus=block/03_paragraph

## Issues

If you run into any problems with the gem,

1. First see if the problem exists with the regular _kramdown_ gem.  If it does, then the issue should be opened on the [main kramdown repository](https://github.com/gettalong/kramdown)
2. Open an issue on this repository

## Credit

All credit for _kramdown_ belongs to Thomas Leitner.  _motion-kramdown_ is a simple modifcation to make it work with RubyMotion.

## License

_motion-kramdown_ is released under the MIT license (see the **COPYING** file) and therefore can easily be used in commercial projects.

However, if you use _motion-kramdown_ in a commercial setting, please consider **contributing back any changes** for the benefit of the community and/or **making a donation** (see the links in the sidebar on the [kramdown homepage](http://kramdown.gettalong.org/).
