class Command
  attr_reader :description
  def initialize(description)
    @description = description
  end

  def execute
  end

  def undo_execute
  end
end

require "fileutils"

# Fileの作成を命じるコマンド
class CreateFile < Command
  def initialize(path, contents)
    super("Create file: #{path}")
    @path = path
    @contents = contents
  end

  def execute
    f = File.open(@path, "w")
    f.write(@contents)
    f.close
  end

  def undo_execute
    File.delete(@path)
  end
end

# Fileの削除を命じるコマンド
class DeleteFile < Command
  def initialize(path)
    super("Delete file: #{path}")
    @path = path
  end

  def execute
    if File.exists?(@path)
        @content = File.read(@path)
    end
    File.delete(@path)
  end

  def undo_execute
    f = File.open(@path, "w")
    f.write(@contents)
    f.close()
  end
end

# Fileをコピーする命令
class CopyFile < Command
  def initialize(source, target)
    super("Copy file: #{source} to #{target}")
    @source = source
    @target = target
  end

  def execute
    FileUtils.copy(@source, @target)
  end

  def undo_execute
    File.delete(@target)
  end
end

class CompositeCommand < Command
  def initialize
    @commands = []
  end

  def add_command(cmd)
    @commands << cmd
  end

  def execute
    @commands.each{ |cmd| cmd.execute }
  end

  def undo_execute
    @commands.reverse.each{ |cmd| cmd.undo_execute }
  end

  def description
    description = ""
    @commands.each { |cmd| description += cmd.description + "\n" }
    description
  end
end

command_list = CompositeCommand.new

# コマンドを追加
command_list.add_command(CreateFile.new("file1.txt", "hello world\n"))
command_list.add_command(CopyFile.new("file1.txt", "file2.txt"))
command_list.add_command(DeleteFile.new("file1.txt"))

# コマンドを実行
command_list.execute
puts (command_list.description)

# コマンドの取り消し
command_list.undo_execute