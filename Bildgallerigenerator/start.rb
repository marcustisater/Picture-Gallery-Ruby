load 'search.rb'
require 'Devil'
require 'fileutils'

start = Searching.new()    #Skapar en instans(object) av classen ifrån search.rb. CLassen Searching alltså
folder = start.ask_name()  #anropar metoden ask_name från objectet test som returnerar folder sökvägen
start.print_file(folder)   #anropar metoden print_file från objectet test med folder(sökvägen) 
start.htmlwebpage            #anropar metoden htmlsidan från objectet test som skriver ut själva html hemsidan


