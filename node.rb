class DOMNode
  attr_accessor :element,:classes,:id,:children,:parent
  def initialize(element, classes = [], id = nil, children = [], parent = nil,text = ["",""])

    @element = element
    @text = text
    @classes = classes
    @id = id
    @children = children
    @parent = parent
  end

  def attrs
    result = ""
    result += " class=#{classes}" if @classes.any?
    result += " id=#{@id}" unless @id.nil?

    result
  end

  def classes
    @classes.join(" ")
  end

  def left_text
    @text[0]
  end

  def right_text
    @text[1]
  end

  def add_before_text(t)
    @text[0] += t
  end

  def add_after_text(t)
    @text[1] += t
  end

  def text
    @text[0] + " " + @text[1]
  end

  def pprint
    p "Element: #{@element}, Text:#{@text}, Classes:#{@classes}, Id:#{@id}, Parent: #{@parent.element}"
  end

end