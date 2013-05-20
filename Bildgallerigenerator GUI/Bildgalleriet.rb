require 'Devil'
require 'fileutils'
require 'tkextlib/bwidget/setup.rb'
require 'tkextlib/setup.rb'
require "mini_magick"


class Searching
  @@bilder                                                #Class variabel som håller bilderna
  @@thumbnail                                             #Class variable som håller alla thumbnails
  @@folder                                                #Class variable som håller foldern där bilderna ligger
  @@folderdest                                            #Class variable som håller destinations foldern
    
  def copy_files                                           #Funktionen för att kopiera bilderna till destinationen.
  
      @@bilder.each { |f| FileUtils.cp File.expand_path(f), @@folderdest} #Kopierar varje fil till destinationen
      Dir.chdir(@@folderdest)                             #Ändrar katalogen till dest foldern så vi kan läsa in alla bilderna nedan. 
      @@bilder.clear                                      #Tömmer class variablen för den innehåller själva pathen plus filen
      @@bilder =Dir['*.{jpg,png,gif}']                    #lagrar endast bils namnen i variabeln.  
       
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
  fileHtml.puts "<TD><a href=\"#{@@bilder[i]}\"><img src=\"#{@@thumbnails[i]}\"></a></TD>"
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
  puts "Antligen klar med bildgalleriet"
end

def grafiken

  root = TkRoot.new {
  title  "Marcus Bildgalleri"
  background "gold"
  minsize(175,230)
  }
  
  menu_click_folder = Proc.new {             #tillverkning av rutan, en procidur (prod)
   dirname = Tk.chooseDirectory
   puts dirname
   if dirname == ""
   puts "" 
   else
   Dir.chdir(dirname)
   Dir.pwd
     @@bilder = Dir.glob('**/*.{jpg,png,gif}')
   
    if @@bilder.empty?            # lite som en rekrusiv prog
      Tk.messageBox(
           'type'    => "ok",  
           'icon'    => "info", 
           'title'   => "Klar",
           'message' => "Hittade inga bilder i foldern prova igen"
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
           @@bilder.each do |bild|
             puts bild
             generate bild, "thumb"+bild, :thumb
           end
         htmlsidan
         progress.stop
           progress.destroy
           stop = Tk.messageBox(
                                    'type'    => "ok",  
                                    'icon'    => "info", 
                                    'title'   => "Klar",
                                    'message' => "Bildagalleriet ar klart")
           
         end  
 
  }
    
  
  menu_click = Proc.new {
    Tk.messageBox(
      'type'    => "ok",  
      'icon'    => "info",
      'title'   => "Title",
      'message' => "Message"
    )
  }
    menu_click2 = Proc.new {
        Tk.messageBox(
          'type'    => "ok",  
          'icon'    => "info",
          'title'   => "Title",
          'message' => "Bra Jobbat!"
        )
    
  }
  menu_click3 = Proc.new {
    @@folderdest = Tk.chooseDirectory  
      
    }
  text = TkText.new(root) {  #textrutan
    height 10
    width 40
    background "grey"
    font TkFont.new('times 10 bold')
    pack("side" => "top",  "padx"=> "80", "pady"=> "10")
    
  }
  
  text.insert 1.40, "Hej och valkommen till bildgallerigeneratorn  
For att tillverka ditt bildgalleri moste du valja en mapp dar du vill ta ut dina bilder ifron och en destinations mapp dar dina bilder laggar sig i. Var vanligen valj detta innan du startar programmet"
  #text i rutan

  button_start = TkButton.new(root) do        #Knappen skapas       
    text "Skapa bildgalleriet"
    borderwidth 5
    font TkFont.new('times 15 bold')
    foreground  "blue"

    command  start

    pack("side" => "bottom")
  end
  
  file_menu = TkMenu.new(root)        #Flikarna i menu_bar
  
  file_menu.add('command',
                'label'     => "Valj vilken mapp du vill ta ut dina bilder ifran",
                'command'   => menu_click_folder,
                'underline' => 0)
  file_menu.add('command',
                'label'     => "Valj vilken destinations mapp dina bilder vill vara i",
                'command'   => menu_click3,
                'underline' => 0)
  file_menu.add('command',
                'label'     => "Close",
                'command'   => menu_click,
                'underline' => 0)
                
  file_menu.add('command',
                  'label'     => "Tryck",
                  'command'   => menu_click2,
                  'underline' => 0)
  
  menu_bar = TkMenu.new                 #Skapar våran flikbar
  menu_bar.add('cascade',
               'menu'  => file_menu,  
               'label' => "Bildgalleri Funktioner")
  
  root.menu(menu_bar)
  
 
  Tk.mainloop

end
end


  
