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
    attr_reader :permission, :hardlink, :owner, :group, :size, :timestamp, :name, :blocks, :dotfile

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

  class Formatter
    NUM_OF_COLUMNS = 3

    def initialize(file_stats, all: false, long: false, reverse: false)
      @file_stats = file_stats
      @all = all
      @long = long
      @reverse = reverse
    end

    def render
      @file_stats.sort_by! { |f| ignore_dot_in_dotfile(f.name, f.dotfile) }
      @file_stats.reverse! if @reverse
      @file_stats.reject!(&:dotfile) unless @all
      @long ? render_long_listing : render_short
    end

    private

    def render_short
      file_names = @file_stats.map(&:name)

      max_file_name_length = file_names.map(&:length).max
      file_names.map! { |file_name| file_name.ljust(max_file_name_length) }

      n_rows = (file_names.size / NUM_OF_COLUMNS.to_f).ceil
      # transpose するために、each_slice で不足する要素を nil で埋める
      # https://stackoverflow.com/questions/56412977/ruby-each-slice-into-sub-arrays-and-set-default-element-values-if-last-sub-array
      chunk_file_names = file_names.each_slice(n_rows).to_a.tap { |arr| arr.last.fill(nil, arr.last.length, n_rows - arr.last.length) }
      transposed_file_names = chunk_file_names.transpose

      result = []
      transposed_file_names.each { |n| result << n.join(' ') }
      result.join("\n")
    end

    def render_long_listing
      # total blocks は半分にすると一致するため、2 で割る
      total_blocks = @file_stats.inject(0) { |result, f| result + f.blocks } / 2
      max_size_length = calc_max_size_length

      result = ["total #{total_blocks}"]
      @file_stats.each do |f|
        result << "#{f.permission} #{f.hardlink} #{f.owner} #{f.group} #{f.size.to_s.rjust(max_size_length)} #{f.timestamp} #{f.name}"
      end
      result.join("\n")
    end

    def ignore_dot_in_dotfile(name, dotfile)
      dotfile ? name.delete_prefix('.') : name
    end

    def calc_max_size_length
      sizes = []
      @file_stats.each { |f| sizes << f.size }
      sizes.max.to_s.length
    end
  end
end
