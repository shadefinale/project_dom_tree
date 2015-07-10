class TreeSearcher

  def initialize(tree)
    @tree = tree.stack
  end

  def search_by(sym, input, root=nil)
    root.nil? ? search_root = @tree[0] : search_root = root
     input = force_regex(input.strip)
    results = []
    search_queue = search_root.children.dup

    until search_queue.empty?
      current_child = search_queue.shift
      unless current_child.send(sym).nil?
        results << current_child if current_child.send(sym) =~ input
      end
      current_child.children.each do |child|
        search_queue << child
      end
    end

    results
  end

  def force_regex(input)
    input.is_a?(Regexp) ? input : /#{input}/


  end

  def search_children(some_node, symbol, input)
    search_by(symbol, input, some_node)

  end

  def search_ancestor(some_node, symbol, input)
    results = []
    current = some_node.parent
    until current.nil?
      unless current.send(symbol).nil?
        results << current if current.send(symbol).include? (input.strip)
      end
      current = current.parent
    end
    results
  end

end


