# サックス[Product]
class Saxophone
  def initialize(name)
    @name = name
  end
  def play
    puts "#{@name}は音を奏でています"
  end
end

# トランペット[Product]
class Trumpet
  def initialize(name)
    @name = name
  end

  def play
    puts "トランペット#{@name}は音を奏でています"
  end
end

# 楽器工場[Factory]
class InstrumentFactory
  def initialize(number_instruments)
    @instruments = []
    number_instruments.times do |i|
        instrument = new_instrument("楽器#{i}")
        @instruments << instrument
    end
  end

  def ship_out
    @tmp = @instruments.dup
    @instruments = []
    @tmp
  end
end

# 以下のクラスは、親クラスが汎用的なので追加が楽
class SaxophoneFactory < InstrumentFactory
  def new_instrument(name)
    Saxophone.new(name)
  end
end

class TrumpetFactory < InstrumentFactory
  def new_instrument(name)
    Trumpet.new(name)
  end
end

# オブジェクトを工場で作成
factory = SaxophoneFactory.new(3)
saxpones = factory.ship_out
saxpones.each {|saxpone| saxpone.play }

factory = TrumpetFactory.new(2)
trumpets = factory.ship_out
trumpets.each{|trumpet| trumpet.play }