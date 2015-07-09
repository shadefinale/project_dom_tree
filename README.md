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
<(?<element>\w+)\s*(?<attrs>[^>]*)>(?<inner>.*)<\/.*>

# Capture all attrs and return capture groups with str.scan(regex)
(\S+)=["']?((?:.(?!["']?\s+(?:\S+)=|[>"']))+.)["']?

# turning captured attrs into an options hash
opt_hash = {}
str.scan(regex).each{|cap| opt_hash[cap[0].to_sym] = cap[1]}
opt_hash[:thing] = "the thing" or nil if no 'thing' in attrs





<p class='foo bar' id='baz' name='fozzie'> hello

<p class='foo bar' name='fozzie'> hello