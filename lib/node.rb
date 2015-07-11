class DOMNode
  attr_accessor :element,:id,:children,:parent
  def initialize(element, classes = [], id = nil, text = ["",""])

    @element = element
    @text = text
    @classes = classes
    @id = id
    @children = []
    @parent = nil
  end

  def attrs
    result = ""
    result += " class=\"#{classes}\"" if @classes.any?
    result += " id=\"#{@id}\"" unless @id.nil?

    result
  end

  def is_void?
    voids = %w[area base br
     col command embed
     hr img input keygen
     link meta param
     source track wbr]
    return voids.include? (@element.downcase)
  end

  def add_class(new_class)
    @classes << new_class
  end

  def set_id(new_id)
    @id = new_id
  end

  def classes
    @classes.join(" ")
  end

  def before_text
    @text[0]
  end

  def after_text
    @text[1]
  end

  def before_text=(t)
    @text[0] = t
  end

  def after_text=(t)
    @text[1] = t
  end

  def text
    return @text[1] if @text[0] && @text[0].empty?
    return @text[0] if @text[1] && @text[1].empty?
    return @text[0] + " " + @text[1]
  end

  def pprint
    p "Element: #{@element}, Text:#{@text}, Classes:#{@classes}, Id:#{@id}, Parent: #{@parent.element}"
  end

end