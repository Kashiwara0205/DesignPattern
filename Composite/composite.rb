class Entry
  # ディレクトリ / ファイルの名前を返却
  def get_name
  end

  # ディレクトリ / ファイルのパス返却
  def is_entry
  end

  # ディレクトリ / ファイルの削除を行う
  def remove
  end
end

class FileEntry < Entry
  def initialize(name)
    @name = name
  end

  def get_name
    @name
  end

  def ls_entry(prefix)
    puts(prefix + "/" + get_name)
  end

  def remove
    puts @name + "を削除しました"
  end
end

class DirEntry < Entry
  def initialize(name)
    @name = name
    @directory = Array.new
  end

  def get_name
    @name
  end

  def get_directory
    @directory
  end

  def add(entry)
    @directory.push(entry)
  end

  def ls_entry(prefix)
    puts(prefix + "/" + get_name)
    @directory.each do |e|
      e.ls_entry(prefix + "/" + @name)
    end
  end

  def remove
    @directory.each do |i|
      i.remove
    end
    puts @name + "を削除しました"
  end
end


root = DirEntry.new("root")
tmp = DirEntry.new("tmp")
tmp.add(FileEntry.new("conf"))
tmp.add(FileEntry.new("data"))
root.add(tmp)

tmp2 = DirEntry.new("tmp2")
tmp2.add(FileEntry.new("conf2"))
tmp2.add(FileEntry.new("data2"))
root.add(tmp2)


# directoryの中身はこんな感じ
# [tmp_Obj[conf_Obj, data_Obj], tmp2_Obj[conf2_Obj, data2_Obj]]
root.ls_entry("")


=begin
[[1, 2, 3], [1, 3, 5, [1, 2, 3]]].each do |i|
  p i
end
[[1, 2, 3], [1, 3, 5, [1, 2, 3]]].map{|m| p m}
=end