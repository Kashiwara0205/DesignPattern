class BankAccount
  attr_reader :balance

  def initialize(balance)
    @balance = balance
  end

  # 出金
  def deposit(amount)
    @balance += amount
  end

  # 入金
  def withdraw(amount)
    @balance -= amount
  end
end

# /etc内に存在するデータベースを使用
require "etc"

# ユーザログインを担当する防御Proxy
class BankAccountProxy
  def initialize(real_obj, owner_name)
    @real_obj = real_obj
    @owner_name = owner_name
  end

  def balance
    check_accss
    @real_obj.withdraw(amount)
  end

  def deposit amount
    check_accss
    @real_obj.deposit(amount)
  end

  def withdraw amount
    check_accss
    @real_obj.withdraw(amount)
  end

  def check_accss
    if (Etc.getlogin != @owner_name)
      raise "LoginError"
    end
  end
end
# etcの環境を作ってないので動かないけど

# PCのログインユーザーでログインしてから操作
account = BankAccount.new(100)
proxy = BankAccountProxy.new(account, "kashiwara")

puts proxy.deposit(50)
puts proxy.withdraw(10)

# ログインユーザじゃない場合操作不能
account = BlankAccount.new(100)
proxy = BankAccountProxy.new(account, "no_login_user")
puts proxy.deposit(50)