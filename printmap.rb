require 'devil'
require 'fileutils'

class Searching
  def ask_name() #funktion för gets.chomp (Fråga vilken mapp)
    puts "Vilken mapp vill du printa ut dina bilder ifron? Ange vart mappen ligger i din dator for att programmet skall lista ut de och de skapar thumbnails och en html hemsida med dina bilder po"
    return gets.chomp 
  end
  
  def print_file (filename)  #Funktionen för att söka igenom en mapp och printa ut bilderna
    begin
      Dir.chdir(filename)  #Byt till det directory som vi specifiserat
      sourcefolder=Dir.pwd #Ta ut folder sökvägen
      bilderna = Dir['*.jpg'] #Hämta alla jpg bilder som finns i foldern och spara dem i en array
      #puts Dir['*gif']
      #puts Dir['*png']
      
      sourcefolder = sourcefolder + "/*" # lägg till foldersökvägen så den kan användas i Dir.glob och i FilUtils.cp metoderna. 

      Dir.glob(sourcefolder) {|f| FileUtils.cp File.expand_path(f), "c:/Temp/test" } #Kopierar filerna till en temp folder OBS foldern måste finnas på våran dator     Dir.chdir("C:/Temp/test") # Ändrar directoryt så våra thumbnails skapas i temp/test. 
      i=0         #Börja iterationen på 0
      while i < bilderna.length     #itterera så länge i är mindre än längden på array så det fungerar för hur många bilder som helst.
     
      Devil.with_image(bilderna[i]) do |img|  #Devil används för att skapa thumbnails
                     img.thumbnail2(150)
                     img.gamma_correct(1.6)
                     img.save("thumbnail_"+bilderna[i]) #Lägger till thumbnail i namnet för bilderna som blivit thumbnails
              end 
    i=i+1  #Stega ett steg och kör om while loopen 
    end
    rescue                 #om mappen inte finns, frågar den igen som en while loop
     puts "Mappen existera inte i din dator. Kontrollera vart den ligger och var vanligen skriv den igen"
     file = ask_name()  #anropar funktionen
     print_file(file)  #skriver ut
  end
end
end

fileHtml = File.new("bildgalleri.html", "w+")  #skapar en html fil (marcus.html)
fileHtml.puts "<!DOCTYPE html>"  #standard HTML kod härefter...
fileHtml.puts "<HTML><BODY BGCOLOR='green'>"
fileHtml.puts "<CENTER>this is my crappy webpage</CENTER><br>"
fileHtml.puts "<CENTER><FONT COLOR='teal'> Jag heter Marcus </FONT></CENTER>"


test = Searching.new()
folder = test.ask_name()  #anropar funktionen
test.print_file(folder) #skriver ut
puts "Whooooooo, Check your HTML page (marcus.html)"


Dir.glob("C:/Temp/test/thumbnail*").each do |add|   #Här skriv mina bilder ut på HTML hemsidan. Glob tar ifrån temp mappen/test/ och sedan alla som börjar på thumbnails
fileHtml.puts "<img src='#{add}'>" 
end
fileHtml.puts "</BODY></HTML>"  #avslutar html med </body> </html> tags.

