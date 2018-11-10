class Expression
  def |(other)
    Or.new(self, other)
  end

  def &(other)
    And.new(self, other)
  end
end

require "find"
class All < Expression
  def evaluate(dir)
    results= []
    Find.find(dir) do |p|
      # ディレクトリならスキップ
      next unless File.file?(p)
      results << p
    end
    results
  end
end

class FileName < Expression
  def initialize(pattern)
    # ファイル名とマッチさせるためのパターン
    @pattern = pattern
  end

  def evaluate(dir)
    results= []
    Find.find(dir) do |p|
      next unless File.file?(p)
      name = File.basename(p)
      # ファイル名とパターンが一致するか
      results << p if File.fnmatch(@pattern, name)
    end
    results
  end
end

class Bigger < Expression
  def initialize(size)
    @size = size
  end

  def evaluate(dir)
    results = []
    Find.find(dir) do |p|
      next unless File.file?(p)
      # 指定されたサイズより多いものを格納
      results << p if( File.size(p) > @size)
    end
    results
  end
end

class Writable < Expression
  def evaluate(dir)
    results = []
    Find.find(dir) do |p|
      next unless File.file?(p)
      # 書き込み可能なものを格納
      results << p if( File.writable?(p) )
    end
    results
  end
end

class Or < Expression
  def initialize(expression1, expression2)
    @expression1 = expression1
    @expression2 = expression2
  end

  def evaluate(dir)
    result1 = @expression1.evaluate(dir)
    result2 = @expression2.evaluate(dir)
    (result1 + result2).sort.uniq
  end
end

class And < Expression
  def initialize(expression1, expression2)
    @expression1 = expression1
    @expression2 = expression2
  end

  def evaluate(dir)
    result1 = @expression1.evaluate(dir)
    result2 = @expression2.evaluate(dir)
    puts "-------------------"
    puts "result1:"
    print (result1)
    puts
    puts "result2:"
    print (result2)
    puts
    puts "-------------------"
    (result1 & result2)
  end
end


complex_expression1 = And.new(FileName.new('*.mp3'), FileName.new('big*'))
puts complex_expression1.evaluate('13_test_data')

complex_expression2 = Bigger.new(1024)
puts complex_expression2.evaluate('13_test_data')

# &はExoressinクラスのメソッド FileNameは継承しているので使える
complex_expression3 = FileName.new('*.mp3') & FileName.new('big*')
puts complex_expression3.evaluate('13_test_data')

complex_expression4 = All.new
puts complex_expression4.evaluate('13_test_data')

# 積集合をANDで使っている
puts [1, 2, 3, 4] & [1, 2, 3]
