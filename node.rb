class DOMNode
  attr_accessor :element,:text,:classes,:id,:children,:parent
  def initialize(element, classes = [], id = nil, children = [], parent = nil,text = "")

    @element = element
    @text = text
    @classes = classes
    @id = id
    @children = children
    @parent = parent
  end
  

  def classes
    @classes.join(" ")
  end

  private

    def pprint
      p "Element: #{@element}, Text:#{@text}, Classes:#{@classes}, Id:#{@id}, Parent: #{@parent.element}"
    end

end