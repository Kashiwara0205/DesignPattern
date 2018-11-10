require 'singleton'

class SingletonObject
  include Singleton
  attr_accessor :counter

  def initialize
    @counter = 0
  end
end

# Singletonになったら.instanceでしかオブジェクトを作れない
obj1 = SingletonObject.instance
obj1.counter += 1
puts(obj1.counter)

obj2 = SingletonObject.instance
obj2.counter += 1
puts(obj2.counter)

obj1.counter += 1
puts(obj2.counter)

# newしたらエラー扱い
# SingletonObject.new