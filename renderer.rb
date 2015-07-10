require_relative './dom.rb'
require_relative './node.rb'

class NodeRenderer

  def initialize(tree)
    @tree = tree.stack
  end

  def render(node=nil)
    node.nil? ? spotlight = @tree[0] : spotlight = node

    child_count = 0
    element_count = Hash.new(0)

    child_queue = spotlight.children.dup
    until child_queue.empty?
      current_child = child_queue.shift
      child_count += 1
      element_count[current_child.element] += 1
      current_child.children.each do |child|
        child_queue << child
      end
    end
    puts "This node has #{child_count} sub nodes"
    puts "This node has the following count of each element:"
    element_count.each do |key, value|
      print "#{key}, #{value}"
      puts
    end

    puts "Element attributes:"
    p "Element: #{spotlight.element}, text: #{spotlight.text}, classes: #{spotlight.classes}, id:#{spotlight.id}"
  end

end