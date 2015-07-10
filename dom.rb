require_relative './node.rb'

class DOMReader

  attr_reader :stack

  def initialize
    @file = nil
    @root = DOMNode.new("Document")
    @stack = [@root]
  end

  def build_tree(file)
    @file = File.readlines(file).each {|l| l.strip!}.join("")
    until @file.empty?
      tag = get_tag
      if tag.captures.any?
        parse_opening_tag(tag)
      else
        parse_closing_tag(tag)
      end
    end
  end

  private

    def start_tag_regex
      /<(?<element>\w+)\s*(?<attrs>[^>]*)>/
    end

    def end_tag_regex
      /<\/[^<>]*>/
    end

    def attr_parse_regex
      /(\S+)=["']?((?:.(?!["']?\s+(?:\S+)=|[>"']))+.)["']?/
    end

    def parse_opening_tag(tag)
      new_node = parse_tag(tag)
      new_node.parent = @stack[-1]
      @stack[-1].children << new_node
      @stack[-1].add_before_text(tag.pre_match)
      @stack << new_node
      @file = tag.post_match
    end

    def parse_closing_tag(tag)
      @stack[-1].add_after_text(tag.pre_match)
      @stack.pop
      @file = tag.post_match
    end

    def get_tag
      spos = @file =~ (start_tag_regex)
      epos = @file =~ (end_tag_regex)

      if spos && epos
        spos < epos ? (tag = @file.match(start_tag_regex)) : (tag = @file.match(end_tag_regex))
      elsif !epos
        tag = @file.match(start_tag_regex)
      elsif !spos
        tag = @file.match(end_tag_regex)
      end
      tag
    end

    def parse_tag(tag)
      m = tag
      element_type = m.captures[0]
      attrs = m.captures[1..-1]
      attrs = attrs.join(" ")
      attrs = attrs.scan(attr_parse_regex)

      options = {}
      attrs.each do |opt|
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






