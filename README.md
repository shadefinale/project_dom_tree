# project_dom_tree
Like leaves on the wind

Mike and Donald

[A data structures, algorithms, file I/O, ruby and regular expression (regex) project from the Viking Code School](http://www.vikingcodeschool.com)


tags: html       attributes:  
      head       class
      title      id
      body
      div
      main
      header
      h1
      h2
      ul
      li


^<.*>     =  grabs the tags (without text inside tag)

^<(?<type>\w+)\s*(?<attr>class='(.*?)')\s*(?<attr2>id='(.*?)').*>
<!-- ^<(?<element>\w+)\s*(class=(?<class>'.+?'))> -->
<(?<element>\w+)\s*(?<other>.+?)>    
<(?<element>\w+)\s*(?<other>.+?)>(?<inner>.*)<\/.*> (same but grabs inside text)

# Capture paired tag, get element type, attributes, inner text/divs
<(?<element>\w+)\s*(?<attrs>[^>]*)>(?<inner>.*)<\/(?<element2>.*)>

# Capture all attrs and return capture groups with str.scan(regex)
(\S+)=["']?((?:.(?!["']?\s+(?:\S+)=|[>"']))+.)["']?

# turning captured attrs into an options hash
opt_hash = {}
str.scan(regex).each{|cap| opt_hash[cap[0].to_sym] = cap[1]}
opt_hash[:thing] = "the thing" or nil if no 'thing' in attrs

read it all into one line.

read through our one line
when we hit a opening tag
create a new node
give it it's parent (peek at stack)
give parent new child (also peek at stack)
put new node on top of stack

when we hit text before next tag
append text to current node on stack (peek at stack)

when we hit a closing tag
pop from stack
next

when we find a tag
check if there's text before the tag with MatchData.pre_match
append text to current stack's text!
MatchData.post_match returns the whole searched string AFTER the first match!
@file = MatchData.post_match