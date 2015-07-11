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

  def render_tree
    root = @tree[0].children[0].dup
    recreate(root, 1)
  end

  def recreate(node, spaces)
    if node.children.any?
      result = ""
      node.children.each do |child|
        result += (" " * spaces * 2) + recreate(child, spaces + 1) + "\n"
      end
      return outer(node, result, spaces)
    else
      return inner(node, result, spaces)
    end
  end

  private

  def outer(node, result, spaces)
    "<#{node.element}#{node.attrs}>" +
    "\n" +
    left_text(node, spaces) +
    result +
    right_text(node, spaces) +
    special_space(spaces * 2) +
    "</#{node.element}>"
  end

  def left_text(node, spaces)
    unless node.before_text.empty?
      (" " * spaces * 2) + "#{node.before_text}" + "\n"
    else
      ""
    end
  end

  def right_text(node, spaces)
    unless node.after_text.empty?
      (" " * spaces * 2) + "#{node.after_text}" + "\n"
    else
      ""
    end
  end

  def inner(node, result, spaces)
    if node.is_void?
      return "<#{node.element}#{node.attrs}>"
    else
      return "<#{node.element}#{node.attrs}>" + "\n" +
    left_text(node, spaces) + right_text(node, spaces) +
    special_space(spaces * 2)+ "</#{node.element}>"
    end
  end

  def special_space(spaces)
    if spaces > 0
      " " * (spaces - 2)
    else
      ""
    end
  end




end