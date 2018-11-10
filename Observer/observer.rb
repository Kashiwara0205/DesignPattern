require 'observer'
class Employee
  include Observable

  attr_reader :name, :title, :salary

  def initialize(name, title, salary)
    @name = name
    @title = title
    @salary = salary
    add_observer(Payroll.new) # 監視するオブジェクトを登録(Payroll)
    add_observer(TaxMan.new)  # 監視するオブジェクトを登録(TaxMan)
  end

  def salary= (new_salary)
    @salary = new_salary
    changed
    notify_observers(self) # 各、updateメソッドが走る
  end
end

class Payroll
  def update(changed_employee)
    puts "彼の給料は#{changed_employee.salary}になりました！#{changed_employee.title}のために新しい小切手を切ります。"
  end
end

class TaxMan
  def update(changed_employee)
    puts "#{changed_employee.name}に新しい税金の請求書を送ります"
  end
end

john = Employee.new('John', 'Senior Vice President', 5000)
# 代入された瞬間に作動（フック処理）
john.salary = 6000
john.salary = 7000