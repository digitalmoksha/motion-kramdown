#------------------------------------------------------------------------------
def it_behaves_like(name, method = nil)
  @method = method
  behaves_like(name)
end

class Should

  # usage: .should.be_true and .should.be_false
  #------------------------------------------------------------------------------
  def be_true
    self == true
  end
  
  def be_false
    self == false
  end
end

# usage:  .should.be truthy and .should.be falsey
#------------------------------------------------------------------------------
def truthy
  lambda { |obj| obj == true }
end
def falsey
  lambda { |obj| obj == false }
end