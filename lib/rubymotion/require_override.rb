module Kernel
  # Since RubyMotion doesn't support `require` in the code, then let's
  # noop it.  This allows us to keep the original kramdown require statements
  # so that the source is more pure and easier to diff.
  # This _should_ be safe...
  def require(_name)
    # noop
  end
end
