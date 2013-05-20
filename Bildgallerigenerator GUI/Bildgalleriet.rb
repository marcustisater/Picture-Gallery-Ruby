require 'Devil'
require 'fileutils'
require 'tkextlib/bwidget/setup.rb'
require 'tkextlib/setup.rb'
require "mini_magick"


class Searching
  @@pictures                                                #Class variabel som håller bilderna
  @@thumbnail                                             #Class variable som håller alla thumbnails
  @@folder                                                #Class variable som håller foldern där bilderna ligger
  @@folderdest                                            #Class variable som håller destinations foldern
    
  def copy_files                                           #Funktionen för att kopiera bilderna till destinationen.
  
      @@pictures.each { |f| FileUtils.cp File.expand_path(f), @@folderdest} #Kopierar varje fil till destinationen
      Dir.chdir(@@folderdest)                             #Ändrar katalogen till dest foldern så vi kan läsa in alla bilderna nedan. 
      @@pictures.clear                                      #Tömmer class variablen för den innehåller själva pathen plus filen
      @@pictures =Dir['*.{jpg,png,gif}']                    #lagrar endast bils namnen i variabeln.  
       
  end
  
  def generate file, out, type      #argumenten 
    image = MiniMagick::Image.open file
    if type == :thumb
      image.resize "92x92"
    elsif type == :slide
      image.resize "800x600"
    end
    image.write out
    @@thumbnails = Dir.glob('thumb*.{jpg,png,gif}')
  end


def htmlsidan
 
  Dir.chdir(@@folderdest)
  fileHtml = File.new("Marcus.html", "w+")
  fileHtml.puts "<HTML><BODY BGCOLOR='black'>"
  fileHtml.puts "<CENTER><FONT COLOR='white'><TH><h1>Marcus Bildgalleri</h1></TH></FONT></CENTER><br>"
  fileHtml.puts "<TABLE BORDER='1' ALIGN='center'>"
  i = 0
  td = 0
  while i < @@thumbnails.length
  fileHtml.puts "<TD><a href=\"#{@@pictures[i]}\"><img src=\"#{@@thumbnails[i]}\"></a></TD>"
  i=i+1
  td = td+1
  if td == 4
    fileHtml.puts "<TR></TR>"
    td=0
  end
  end
  fileHtml.puts "</TABLE>"
  fileHtml.puts "</BODY></HTML>"
  fileHtml.close()
  puts "You're Picturegalllery is completed"
end

def grafiken

  root = TkRoot.new {
  title  "Marcus Picturegalllery"
  background "gold"
  minsize(175,230)
  }
  
  choice_pic_map = Proc.new {             #tillverkning av rutan, en procidur (prod)
   dirname = Tk.chooseDirectory
   puts dirname
   if dirname == ""
   puts "" 
   else
   Dir.chdir(dirname)
   Dir.pwd
     @@pictures = Dir.glob('**/*.{jpg,png,gif}')
   
    if @@pictures.empty?            # lite som en rekrusiv prog
      Tk.messageBox(
           'type'    => "ok",  
           'icon'    => "info", 
           'title'   => "Done",
           'message' => "Didn't find any picture in this folder. Sorry"
         )
    else

      Dir.chdir(dirname) 
      
                           
    end
   end
  }
  
  start = Proc.new {   #Vad som sker när vi klickar på start pic gallery knappen
    
  
    copy_files
         progress =  Tk::Tile::Progressbar.new(root, :mode=>'indeterminate', :orient=>'horizontal')
         progress.pack
         progress.place('height' => 25,'width'  => 200,'x' => 50,'y'=> 150)
         Thread.new do
           progress.start
           @@pictures.each do |img|
             puts bild
             generate bild, "thumb"+img, :thumb
           end
         htmlsidan
         progress.stop
           progress.destroy
           stop = Tk.messageBox(
                                    'type'    => "ok",  
                                    'icon'    => "info", 
                                    'title'   => "Klar",
                                    'message' => "You're picture gallery is completed")
           
         end  
 
  }
    
  
  close_program = Proc.new {
    root.destroy
  }
    test = Proc.new {
        Tk.messageBox(
          'type'    => "ok",  
          'icon'    => "info",
          'title'   => "Test123",
          'message' => "Testbutton"
        )
    
  }
  choice_destination = Proc.new {
    @@folderdest = Tk.chooseDirectory  
      
    }
  text = TkText.new(root) {  #textrutan
    height 10
    width 40
    background "grey"
    font TkFont.new('times 10 bold')
    pack("side" => "top",  "padx"=> "80", "pady"=> "10")
    
  }
  
  text.insert 1.40, "Welcome to this program! Follow the instroductions under File then press the button to create the gallery"

  button_start = TkButton.new(root) do        #Knappen skapas       
    text "Create Picturegalllery"
    borderwidth 5
    font TkFont.new('times 15 bold')
    foreground  "blue"

    command  start

    pack("side" => "bottom")
  end
  
  file_menu = TkMenu.new(root)        #Flikarna i menu_bar
  
  file_menu.add('command',
                'label'     => "Choice your folder were the pictures you want to make a picturegallery from are localized ",
                'command'   => choice_pic_map,
                'underline' => 0)
  file_menu.add('command',
                'label'     => "Choice an destination folder for your pictures and thumbnails",
                'command'   => choice_destination,
                'underline' => 0)
  file_menu.add('command',
                'label'     => "Close",
                'command'   => close_program,
                'underline' => 0)
                
  file_menu.add('command',
                  'label'     => "Press it..",
                  'command'   => test,
                  'underline' => 0)
  
  menu_bar = TkMenu.new                 #Skapar våran flikbar
  menu_bar.add('cascade',
               'menu'  => file_menu,  
               'label' => "File")
  
  root.menu(menu_bar)
  
 
  Tk.mainloop

end
end


  
