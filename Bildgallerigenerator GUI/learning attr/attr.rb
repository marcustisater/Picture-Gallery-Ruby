class Ketchup
attr_accessor :hello

def word 
	puts"TOMATKETCHUP"
end


def greet
	@hello = word
end


end


class Tomat

attr_accessor :run

  def initialize()
    @run = Ketchup.new();
  end


def idiot
	@run.greet
end
end


gui = Tomat.new()

gui.idiot
