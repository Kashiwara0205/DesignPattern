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

# Adapterは1クッション挟んでるだけ
class Adapter
  def initialize(string)
    @old_printer = OldPrinter.new(string)
  end
  
  #      旧                 新
  # show_with_paren → print_week に変更
  def print_week
    @old_printer.show_with_paren
  end

  #      旧                 新
  # show_with_aster → print_strong に変更
  def print_strong
    @old_printer.show_with_aster
  end
end

p = Printer.new(Adapter.new("Hello"))
p.print_week
p.print_strong