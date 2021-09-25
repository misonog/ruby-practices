# frozen_string_literal: true

require 'date'

class Format
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
    @file_stats.reject! { |f| /^[.]+/.match?(f.name) } unless @all
    @long ? render_long_listing : render_short
  end

  private

  def render_short
    file_names = @file_stats.map(&:name)

    n_rows = (file_names.size / NUM_OF_COLUMNS.to_f).ceil
    # transpose するために、each_slice で不足する要素を nil で埋める
    # https://stackoverflow.com/questions/56412977/ruby-each-slice-into-sub-arrays-and-set-default-element-values-if-last-sub-array
    chunk_file_names = file_names.each_slice(n_rows).to_a.tap { |arr| arr.last.fill(nil, arr.last.length, n_rows - arr.last.length) }

    # 列の中で最大長のファイル名に合わせる
    chunk_file_names.map! do |f|
      max_file_name_length = f.map(&:length).max
      f.map! { |file_name| file_name.ljust(max_file_name_length) }
    end

    transposed_file_names = chunk_file_names.transpose

    transposed_file_names.map { |n| n.join('  ') }.join("\n")
  end

  def render_long_listing
    # total blocks は半分にすると一致するため、2 で割る
    total_blocks = @file_stats.inject(0) { |result, f| result + f.blocks } / 2
    max_size_length = calc_max_size_length

    result = ["total #{total_blocks}"]
    @file_stats.each do |f|
      result << "#{f.permission} #{f.hardlink} #{f.owner} #{f.group} #{f.size.to_s.rjust(max_size_length)} #{f.timestamp.strftime('%b %d %H:%M')} #{f.name}"
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
