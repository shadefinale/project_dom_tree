class DOMNode
  attr_reader :element,:text,:classes,:id,:children,:parent
  def initialize(element, classes = [], id = nil, children = [], parent = nil,text = "")

    @element = element
    @text = text
    @classes = classes
    @id = id
    @children = children
    @parent = parent
  end
end