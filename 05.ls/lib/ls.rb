# frozen_string_literal: true

require 'date'
require 'etc'

module LS
  def self.generate_path_list(path)
    ls = []
    Dir.foreach(path) do |entry|
      ls << File.join(path, entry)
    end

    ls
  end

  def self.convert_path_to_class(paths)
    paths.map { |path| LS::FileStat.new(path) }
  end

  class FileStat
    def initialize(path)
      fs = File::Stat.new(path)

      @permission = convert_octal_to_symbol(fs.mode.to_s(8))
      @hardlink = fs.nlink
      @owner = Etc.getpwuid(fs.uid).name
      @group = Etc.getgrgid(fs.gid).name
      @size = fs.size
      @timestamp = fs.mtime.strftime('%b %d %H:%M')
      @name = File.basename(path)
      @blocks = fs.blocks
      @dotfile = dotfile?(@name)
    end

    private

    def convert_octal_to_symbol(mode)
      ftypes = { '01': 'p', '02': 'c', '04': 'd', '06': 'b', '10': '-', '12': 'l', '14': 's' }
      permissions = { '0': '---', '1': '--x', '2': '-w-', '3': '-wx', '4': 'r--', '5': 'r-x', '6': 'rw-', '7': 'rwx' }

      mode_padding = mode.rjust(6, '0')

      # ファイルタイプの変換
      result = ftypes[mode_padding[0, 2].intern]
      # アクセス権の変換
      mode_padding.chars.last(3).each do |s|
        result += permissions[s.intern]
      end

      result
    end

    def dotfile?(name)
      /^[.]+[^.]+/.match?(name)
    end
  end
end
