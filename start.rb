require 'devil'
require 'fileutils'
load 'search.rb'
load 'html.rb'

test = Searching.new()
folder = test.ask_name()  #anropar funktionen
test.print_file(folder) #skriver ut
puts "Whooooooo, Check your HTML page (marcus.html)"

