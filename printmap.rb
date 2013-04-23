require 'devil'
class Marcus


def ask_name() #funktion för gets.chomp (Fråga vilken mapp)
  puts "Vilken mapp vill du printa ut dina bilder ifron? Ange vart mappen ligger i din dator for att programmet skall lista ut de"
  return gets.chomp 
end
 
 def balle
 	puts "Hennig dominerar pa fiol"
 end


def print_file (filename)  #Hela Funktionen för att söka igenom en mapp och printa ut bilderna
	i=0
	while i <= # Använda arrayen som en slut eftersom vi inte vet hur många bilder som finns. Det måste vara dynamiskt.
	i = i+1
	
	begin
		Dir.chdir(filename)
		baba = Dir['*.jpg']    #lagras i en array, som vi sedan kan aropa
		#puts Dir['*gs if'] 
		#puts Dir['*png']

		i=0         #Börja iterationen på 0
      while i < bilderna.length     #itterera så länge i är mindre än längden på array så det fungerar för hur många bilder som helst. Vi vet ju inte hur många bilder som finns i mappen
     
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
end

daniel = Marcus.new  #instans av en class
henning = Marcus.new 


file = daniel.ask_name()  #anropar funktionen

#daniel.print_file(bilder[1]) #skriver ut
#henning.balle #anropar funktionen  #henning innehåller hela classen och kan göra allt men vi säger bara åt honom att göra balle methoden.
daniel.print_file(file) #skriver ut