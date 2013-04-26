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
     #Dir['*gif']
     #Dir['*png']
      
      sourcefolder = sourcefolder + "/*" # lägg till * till foldersökvägen så den kan användas i Dir.glob samt i FilUtils.cp metoderna. 
      
      
      Dir.glob(sourcefolder) {|f| FileUtils.cp File.expand_path(f), "c:/Temp/test" } #Kopierar filerna till en temp folder OBS foldern måste finnas får fixa detta senare.
      Dir.chdir("C:/Temp/test") # Ändrar directoryt till temp foldern så thumbnails vi skapar nedan sparas där.
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