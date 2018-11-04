class BankAccount
  attr_reader :balance

  def initialize(balance)
    puts "Bankccountを生成しました"
    @balance = balance
  end

  def deposit(amount)
    @balance += amount
  end

  def withdraw(amount)
    @balance -= amount
  end
end

class VirtualAccountProxy
  def initialize(starting_balance)
    puts "VirtualAccountProxyを生成しました。 BankAccountはまだ生成していません。"
    @starting_balance = starting_balance
  end

  def balance
    subject.balance
  end

  def deposit(amount)
    subject.deposit(amount)
  end

  def withdraw(amount)
    subject.withdraw(amount)
  end

  def announce
    "Virtual Account Proxyが担当するアナウンス"
  end

  def subject
    # @subjectがあればそれを返すなければ、作成
    @subject || (@subject = BankAccount.new(@starting_balance))
  end
end

proxy = VirtualAccountProxy.new(100)
puts proxy.announce
# BankAccountオブジェクトを作成してから操作
puts proxy.deposit(50)
puts proxy.withdraw(10)