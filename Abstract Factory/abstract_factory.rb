class Duck
  def initialize(name)
    @name = name
  end

  def eat
    puts "アヒル#{@name}は食事中です"
  end
end

class Frog
  def initialize(name)
    @name = name
  end

  def eat
    puts "カエル#{@name}は食事中です"
  end
end

class Algae
  def initialize(name)
    @name = name
  end

  def grow
    puts "藻#{@name}は成長中です"
  end
end

class WeaterLily
  def initialize(name)
    @name = name
  end

  def grow
    puts "スイレン#{@name}は成長中です"
  end
end

# オブジェクトを１つの箱にまとめる
# これによる矛盾があるオブジェクトの生成を防ぐのだ
# 下のクラスがまとめる箱となる
class OrganismFactory
  def initialize(number_animals, number_plants)
    # 池の動物
    @animals = []
    number_animals.times do |i|
      animal = new_animal("動物#{i}")
      @animals << animal
    end

    # 池の植物
    @plants = []
    number_plants.times do |i|
      plant = new_plant("植物#{i}")
      @plants << plant
    end
  end

  def get_animals
    @animals
  end

  def get_plants
    @plants
  end
end

# カエルと藻の箱を作成する
class FrogAndFactory < OrganismFactory
  private

  def new_animal(name)
    Frog.new(name)
  end

  def new_plant(name)
    Algae.new(name)
  end
end

# アヒルとスイレンの箱を作成する
class DuckAndWaterLilyFactory < OrganismFactory
  private

  def new_animal(name)
    Duck.new(name)
  end

  def new_plant(name)
    WeaterLily.new(name)
  end
end

# カエルと藻の箱を作成
factory = FrogAndFactory.new(4, 1)

# その中から動物を取り出す
animals = factory.get_animals
animals.each{|animal| animal.eat}

# その中から植物を取り出す
plants = factory.get_plants
plants.each{|plant| plant.grow}

# アヒルとスイレンの箱を作成
factory = DuckAndWaterLilyFactory.new(2, 3)

# その中から動物を取り出す
animals = factory.get_animals
animals.each{|animal| animal.eat}

# その中から植物を取り出す
plants = factory.get_plants
plants.each{|plant| plant.grow}