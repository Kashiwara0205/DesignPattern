# adapter.rbのプログラムを特異クラスで置き換えたものになる
class OldPrinter
  def initialize(string)
    @string = string.dup
  end
  
  def show_with_paren
    puts "(#{@string})"
  end
  
  def show_with_aster
    puts "*#{@string}*"
   end
end

class Printer
  def initialize(obj)
    @obj = obj
  end
  
  def print_week
    @obj.print_week
  end
  
  def print_strong
    @obj.print_strong
  end
end

# Adapterクラスを使うよりシンプルに実装できる
text = OldPrinter.new("Hello")

# print_weekが呼び出されたら
# show_with_parenが呼び出されるように設定
def text.print_week
    show_with_paren
end

# print_strongが呼び出されたら
# show_with_asterが呼び出されるように設定
def text.print_strong
    show_with_aster
end

p = Printer.new(text)
p.print_week
p.print_strong
