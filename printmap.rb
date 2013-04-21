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
	begin
		Dir.chdir(filename)
		baba = Dir['*.jpg']  
		#puts Dir['*gif'] 
		#puts Dir['*png']
		puts baba[0]
	rescue                 #om mappen inte finns, frågar den igen som en while loop
	 puts "Mappen existera inte i din dator. Kontrollera vart den ligger och var vanligen skriv den igen"
	 file = ask_name()  #anropar funktionen
	 print_file(file)  #skriver ut
	end
end
end
daniel = Marcus.new  #instans av en class
henning = Marcus.new 


file = daniel.ask_name()  #anropar funktionen

#daniel.print_file(bilder[1]) #skriver ut
#henning.balle #anropar funktionen  #henning innehåller hela classen och kan göra allt men vi säger bara åt honom att göra balle methoden.
daniel.print_file(file) #skriver ut