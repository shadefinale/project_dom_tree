require_relative './dom.rb'
require_relative './node.rb'
require_relative './renderer.rb'

class TreeSearcher

  def initialize(tree)
    @tree = tree.stack
  end

  def search_by(sym, input, root=nil)
    root.nil? ? search_root = @tree[0] : search_root = root

    results = []
    search_queue = search_root.children.dup
    until search_queue.empty?
      current_child = search_queue.shift
      unless current_child.send(sym).nil?
        results << current_child if current_child.send(sym).include? (input.strip)
      end
      current_child.children.each do |child|
        search_queue << child
      end
    end

    results
  end

  def search_children(some_node, symbol, input)
    search_by(symbol, input, some_node)
    
  end

  def search_ancestor(some_node, symbol, input)
    results = [] 
    current_child = some_node
  end

end



dom = DOMReader.new
dom.build_tree('test.html')
searcher = TreeSearcher.new(dom)

# results = searcher.search_by(:classes, 'bold')
reader = NodeRenderer.new(dom)
results = searcher.search_by(:classes, "top-div")
reader.render(results[0]) if results[0]
result_node = results[0]
results = searcher.search_children(result_node, :classes, "funky")
reader.render(results[0]) if results[0]



