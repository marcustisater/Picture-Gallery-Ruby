fileHtml = File.new("bildgalleri.html", "w+")  #skapar en html fil (marcus.html)
fileHtml.puts "<!DOCTYPE html>"  #standard HTML kod härefter...
fileHtml.puts "<HTML><BODY BGCOLOR='black'>"
fileHtml.puts "<CENTER><H1 FONT COLOR='red'> Mitt bildgalleri! </H1> </CENTER><br>"
fileHtml.puts "<CENTER><H1 FONT COLOR='red'> Marcus </H1></FONT></CENTER>"
fileHtml.puts "<CENTER>"
Dir.glob("C:/Temp/test/thumbnail*").each do |add|   #Här skriv mina bilder ut på HTML hemsidan. Glob tar ifrån temp mappen/test/ och sedan alla som börjar på thumbnails
fileHtml.puts "<img src='#{add}'>" 
end
fileHtml.puts " </CENTER> </BODY></HTML>"  #avslutar html med </body> </html> tags.
system("start bildgalleri.html")
