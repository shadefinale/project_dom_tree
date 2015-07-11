require_relative './lib/dom.rb'
require_relative './lib/node.rb'
require_relative './lib/renderer.rb'
require_relative './lib/searcher.rb'


dom = DOMReader.new
dom.build_tree('test.html')
reader = NodeRenderer.new(dom)

# searcher = TreeSearcher.new(dom)
# results = searcher.search_by(:element, 'textarea')
# results.last.add_class("don and mike added this in at runtime")

# results = searcher.search_by(:id, 'quickMessageDialogContents')
# results.first.set_id("replacedID")


new_html = reader.render_tree
puts new_html
file = File.open('new.html', 'w')
file.write(new_html)
file.close