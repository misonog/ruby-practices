# frozen_string_literal: true

class ShortRenderer
  NUM_OF_COLUMNS = 3

  def initialize(file_stats)
    @file_stats = file_stats
  end

  def render
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
end
