require_relative './node.rb'

class DOMReader

  @@god_regex = /<(?'type'\w+)\s*?(?<attrs>\S+='.*')?\s*?>(?'inner'.*?)<\/\k'type'>/

  @@start_tag_regex = /<(?<element>\w+)\s*(?<attrs>[^>]*)>/
  @@end_tag_regex = /<\/(?<element>.*)>/
  @@attr_parse_regex = /(\S+)=["']?((?:.(?!["']?\s+(?:\S+)=|[>"']))+.)["']?/

  def initialize
    @file = nil
    @root = DOMNode.new("Document")
  end

  def build_tree(file)
    @file = File.readlines(file).each {|l| l.strip!}
    depth = 0
    start_element = 0
    1.upto(@file.length-1) do |counter|
      if @file[counter].scan(@@start_tag_regex).length > 0
        start_element = counter if depth == 0
        depth += 1
      end
      if @file[counter].scan(@@end_tag_regex).length > 0
        depth -= 1
        puts "Creating node from #{@file[start_element]} to #{@file[counter]}" if depth == 0
      end
      p @file[counter]
      p depth
    end

  end

  def create_node(start_point, end_point)
    @file[start_point] = start of element
    @file[end_point] = end_of_element

    @file[start_point+1..end_point-1] = inner
  end

  def parse_tag(tag)
    m = tag.scan(@@start_tag_regex)
    element_type = m[0][0]
    m = m[0]
    m = m[1..-1] if m.length > 1
    m = m.join(" ")
    m = m.scan(@@attr_parse_regex)

    options = {}
    m.each do |opt|
      options[opt[0].to_sym] = opt[1]
    end

    classes = []
    if options[:class]
      classes = options[:class].split(" ")
    end
    id = nil
    id = options[:id] if !(options[:id].nil?)
    dom_node = DOMNode.new(element_type, classes, id)
    dom_node
  end
end






