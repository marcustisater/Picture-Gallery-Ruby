require 'fileutils'
require 'tk'
require "mini_magick"


class Searching
  
  attr_accessor :bilder, :thumbnail, :folder, :folderdest

  def getpictures(folder)
    puts folder
    if folder == ""
      puts "" 
    else
     Dir.chdir(folder)
     @bilder = Dir.glob('**/*.{jpg,png,gif}')

    end
  end


  def copy_files (folderdest)                                  #Funktionen för att kopiera bilderna till destinationen.
      #puts @bilder
      #puts folderdest
      @bilder.each { |f| FileUtils.cp File.expand_path(f), folderdest} #Kopierar varje fil till destinationen
      Dir.chdir(folderdest)  
      #puts folderdest             #Ändrar katalogen till dest foldern så vi kan läsa in alla bilderna nedan. 
      @bilder.clear                                      #Tömmer class variablen, eftersom den har andra mappar i sig. Tar bort filer etc...
      @bilder = Dir['*.{jpg,png,gif}'] 
      #puts @bilder
      return @bilder                  #lagrar endast bilder namnen i variabeln.  
  end
  
  def generate ( file, out, type) 
    image = MiniMagick::Image.open file
    if type == :thumb
      image.resize "92x92"
    elsif type == :slide
      image.resize "800x600"
    end
    image.write out
    @thumbnail = Dir.glob('thumb*.{jpg,png,gif}')
    return @thumbnail
  end


  def htmlsidan(folderdest,thumbnails)
    Dir.chdir(folderdest)
    fileHtml = File.new("Marcus.html", "w+")
    fileHtml.puts "<HTML><BODY BGCOLOR='black'>"
    fileHtml.puts "<CENTER><FONT COsLOR='white'><TH><h1>Marcus Bildgalleri</h1></TH></FONT></CENTER><br>"
    fileHtml.puts "<TABLE BORDER='1' ALIGN='center'>"
    i = 0
    td = 0
    while i < thumbnail.length
    fileHtml.puts "<TD><a href=\"#{@bilder[i]}\"><img src=\"#{@thumbnail[i]}\"></a></TD>"
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
end

class Senap

  attr_accessor :app, :folderdest, :thumbnails, :bilderna

  def initialize()
    @app = Searching.new();
    @folderdest = "";
  end

  def run
    root = TkRoot.new {
    title  "Marcus Bildgalleri"
    background "gold"
    minsize(175,250)
  }

  
  menu_click_folder = Proc.new {             #tillverkning av rutan, en procidur (prod)
   dirname = Tk.chooseDirectory
   @app.getpictures(dirname)
   if @app.bilder.empty?            # lite som en rekrusiv prog
    Tk.messageBox(
        'type'    => "ok",  
        'icon'    => "info", 
        'title'   => "Klar",
        'message' => "Hittade inga bilder i foldern prova igen"
         ) 
    end
   

  }
  
  start = Proc.new {   #Vad som sker när vi klickar på start pic gallery knappen
    
    puts @folderdest
       @bilderna = @app.copy_files(@folderdest)
         progress =  Tk::Tile::Progressbar.new(root, :mode=>'indeterminate', :orient=>'horizontal')
         progress.pack
         progress.place('height' => 25,'width'  => 200,'x' => 50,'y'=> 150)

         Thread.new do
           
           progress.start
           #puts @bilderna
           @bilderna.each do |bild|
            puts bild
           @thumbnails = @app.generate(bild, "thumb"+bild, :thumb)

           end
           
           puts @testa
         @app.htmlsidan(@folderdest,@testa)
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
    root.destroy
    
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
    @folderdest = Tk.chooseDirectory  
    puts @folderdest
    }
  text = TkText.new(root) {  #textrutan
    height 10
    width 40
    background "grey"
    font TkFont.new('times 12 bold')
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





