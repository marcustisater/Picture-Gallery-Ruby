require 'Devil'
require 'fileutils'


class Searching                                           #Class som håller alla våra metoder.  
  @@bilder                                                #Class variabel som håller bilderna
  @@thumbnail                                             #Class variable som håller alla thumbnails 
  def ask_name()                                          #funktion för gets.chomp (Fråga vilken mapp)
    puts "Skriv in vart i datorn dina bilder ligger i for mapp (mapp adressen)"
    return gets.chomp 
  end
  
  def print_file (filename)                               #Metoden för att söka igenom en mapp och printa ut bilderna
    begin
      puts "Tack. Programmet laddar nu upp dina bilder i ett bildgalleri" 
      sleep 2.0                                           #Programmerare måste få ha lite roligt också 
      puts "Detta kan ta ett tag."
      Dir.chdir(filename)                                 #Byt till det directory som vi har angett.

      
      @@bilder = Dir.glob('**/*.{jpg,png,gif}')
      @@bilder.each {|f| FileUtils.cp File.expand_path(f), "c:/Temp/test" } #Kopierar filerna till en temp folder.(cp gör koperingmetoden och expand_path berättar vilken mapp) 
      Dir.chdir("C:/Temp/test")                           #Ändrar directoryt till temp foldern så thumbnails vi skapar nedan sparas där.
      i=0                                                 #Börja iterationen på 0
      while i < @@bilder.length                           #itterera så länge i är mindre än längden på array så det fungerar för hur många bilder som helst.  
      Devil.with_image(@@bilder[i]) do |img|              #Devil används för att skapa thumbnails
                     img.thumbnail2(150)
                     img.save("thumbnail_"+@@bilder[i])   #Lägger till thumbnail i namnet för bilderna som blivit thumbnails
              end 
              
    i=i+1                                                 #Stega ett steg och kör om while loopen
    @@thumbnails=Dir['thumbnail*']
    
    end
  
    rescue                                                #om mappen inte finns, frågar den igen som en while loop
     puts "Mappen existera inte i din dator. Kontrollera vart den ligger och var vanligen skriv igen"
     file = ask_name()                                    #anropar funktionen
     print_file(file)                                     #skriver ut
  end
end

def htmlsidan                                             #Metoden för att skapa själva html koden där bildgalleriet ska synas.  
 
  Dir.chdir("c:/Temp/test")                               #Ändra dit där filerna ligger.    
  fileHtml = File.new("Marcus.html", "w+")                #Öppna en ny html fil.
  fileHtml.puts "<HTML><BODY BGCOLOR='black'>"
  fileHtml.puts "<CENTER><FONT COLOR='white'><TH><h1>Marcus Bildgalleri hemsida</h1></TH></FONT></CENTER><br>"
  fileHtml.puts "<TABLE BORDER='1' ALIGN='center'>"
  i = 0                                                   #Starta en räknare för att itterera genom alla thumbnails.     
  td = 0                                                  #Starta en räknare för att dela upp bilderna i rader om fyra bilder-   
  while i < @@thumbnails.length                           #Starta while loopen som går igenom alla thumnails och skriver ut dem på htmlsidan.
  fileHtml.puts "<TD><a href=\"#{@@bilder[i]}\"><img src=\"#{@@thumbnails[i]}\"></a></FONT></TD>" #Själva utskriften av thumbnails.
  i=i+1                                                   #Räknare för thumnails itterering ökas med ett.  
  td = td+1                                               #Räknare för rad brytningen(fyra bilder per rad) ökas med ett.
  if td == 4                                              #Anger antalet av bilder per rad  
    fileHtml.puts "<TR></TR>"                             #Skapa själva rad brytningen
    td=0                                                  #Nollställ räknaren för radbrytning
  end
  end
  fileHtml.puts "</TABLE>"                                #Avslutar tabellen i html
  fileHtml.puts "</BODY></HTML>"                          #Avsluta html sidan
  fileHtml.close()                                        #Stäng html filen
  system("start c:/Temp/test/Marcus.html")                #Startar bildgalleriet.
end
end

