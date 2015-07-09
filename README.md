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



<p class='foo bar' id='baz' name='fozzie'> hello

<p class='foo bar' name='fozzie'> hello