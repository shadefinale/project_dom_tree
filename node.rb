class DOMNode

  def initialize(element, text = "", classes = nil, id = nil, children = [], parent = nil)
    @element = element
    @text = text
    @classes = classes
    @id = id
    @children = children
    @parent = parent
  end
end