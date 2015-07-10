require_relative './dom.rb'
require_relative './node.rb'
require_relative './renderer.rb'
require_relative './searcher.rb'


dom = DOMReader.new
dom.build_tree('test.html')
searcher = TreeSearcher.new(dom)

# results = searcher.search_by(:classes, 'bold')
reader = NodeRenderer.new(dom)
results = searcher.search_by(:classes, "emphasized")
puts "Searching for class 'emphasized'"
reader.render(results[0]) if results[0]
result_node = results[0]
results = searcher.search_ancestor(result_node, :id, "main-area")
puts "\n\n\nSearching for main-area"
reader.render(results[0]) if results[0]
