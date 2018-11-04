class WriterDecorator
　# ここを汎用的にするためのWtieDecorator
　# SimpleWtierもNumberberingWriterも格納できるようにしておく
  def initialize(real_writer)
    @real_writer = real_writer
  end

  def write_line(line)
    @real_writer.writer_line(line)
  end

  # NumberberingWriter系はここらへんのメソッドは持たないので使えない
  def pos
    @real_writer.pos
  end

  def rewind
    @real_writer.rewind
  end

  def close
    @real_writer.close
  end
end

class NumberberingWriter < WriterDecorator
  def initialize(real_writer)
    super(real_writer)
    # line_numberを定義したかったので省略できなかった
    @line_number = 1
  end

  def write_line(line)
    # SimpleWtierのwrite_lineを呼び出し
    @real_writer.write_line("#{@line_number}: #{line}")
  end
end

class TimestampingWriter < WriterDecorator

  # initalizeは省略するれば親のnitializeが呼ばれてるっぽい

  def write_line(line)
    # NumberberingWriterのwrite_lineを呼び出し
    @real_writer.write_line("#{Time.new}: #{line}")
  end
end

class SimpleWriter
  def initialize(path)
    @file = File.open(path, "w")
  end

  def write_line(line)
    @file.print(line)
    @file.print("\n")
  end

  def pos
    @file.pos
  end

  def rewind
    @file.rewind
  end

  def close
    @file.close
  end
end


writer = SimpleWriter.new("sample1.txt")
writer.write_line("飾り気のない一行")
writer.close

# 処理の前に何かやるのがデコレータである
f = NumberberingWriter.new(SimpleWriter.new("file.txt"))
f.write_line("Hello out there")

f = TimestampingWriter.new(SimpleWriter.new("file2.txt"))
f.write_line("Hello out there")
f.close

# デコレータは先頭に何度もつけることが可能
#  TimestampingWriter(NumberingWriter(SimpleWriter))

# すげーわかりにくいので下に解説を書く
f = TimestampingWriter.new(NumberberingWriter.new(SimpleWriter.new("file3.txt")))
f.write_line("Hello out there")
f.close


# f = TimestampingWriter.new(NumberberingWriter.new(SimpleWriter.new("file3.txt")))の行で以下のような形になる
# オブジェクトの状態
# TimestampingWriter
# WriterDecorator @real_writer = NumberberingWriter
# NumberberingWriter ---------------⇡
# WriterDecorator @real_writer = SimpleWriter

# １回目のwriter_lineでTimestampingWriterのwrite_lineが呼び出される
# 引き続いて、TimestampingWriterオブジェクトが持つ@real_writerに格納してあるNumberberingWriterのwrite_lineが呼び出される
# 最後に NumberberingWriterがもつ@real_writerに格納してあるSimpleWriterのwrite_lineが呼び出されて
# 書き込まれて終了

