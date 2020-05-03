class Node
  include Comparable
  attr_accessor :data, :left, :right

  def initialize(data=nil, left=nil, right=nil)
    @data = data
    @left = left
    @right = right
  end

  def <=>(other)
    other.is_a?(Node) ? data <=> other.data : data <=> other
  end

  def leaf?
    left.nil? && right.nil? 
  end

  def one_child?
    left.nil? != right.nil?
  end
end