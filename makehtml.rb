
fileHtml = File.new("marcus.html", "w+")
fileHtml.puts "<HTML><BODY BGCOLOR='hotpink'>"
fileHtml.puts "<CENTER>this is my crappy webpage</CENTER><br>"
fileHtml.puts "<CENTER><FONT COLOR='teal'> Jag heter Marcus </FONT></CENTER>"
fileHtml.puts "</BODY></HTML>"
fileHtml.close()

system("start marcus.html")
