# frozen_string_literal: true

module WC
  def self.create_word_count_from_path(paths)
    paths.map { |path| create_word_count(File.readlines(path), path) }
  end

  def self.create_word_count(contents, path = '')
    WordCount.new(contents, path)
  end

  class WordCount
    attr_reader :lines, :words, :bytes, :name

    def initialize(contents, path)
      @lines = contents.size
      @words = contents.join.split(/\s+/).count { |s| !s.empty? }
      @bytes = contents.join.bytesize
      @name = path
    end
  end

  class TotalWordCount
    NAME = 'total'

    attr_reader :lines, :words, :bytes, :name

    def initialize(word_counts)
      @lines = word_counts.inject(0) { |result, word_count| result + word_count.lines }
      @words = word_counts.inject(0) { |result, word_count| result + word_count.words }
      @bytes = word_counts.inject(0) { |result, word_count| result + word_count.bytes }
      @name = NAME
    end
  end

  class Format
    def initialize(word_counts, lines: false)
      @word_counts = word_counts
      @word_counts << TotalWordCount.new(@word_counts) if @word_counts.size >= 2
      @lines = lines
      @max_num_legth = calc_max_num_of_digits
    end

    def render
      @lines ? render_lines : render_default
    end

    private

    def render_default
      result = []
      @word_counts.each do |w|
        result << "#{format_number(w.lines)} #{format_number(w.words)} #{format_number(w.bytes)} #{w.name}"
      end
      result.join("\n")
    end

    def render_lines
      result = []
      @word_counts.each do |w|
        result << if @word_counts.size == 1
                    "#{w.lines} #{w.name}"
                  else
                    "#{format_number(w.lines)} #{w.name}"
                  end
      end
      result.join("\n")
    end

    def calc_max_num_of_digits
      digits = []
      @word_counts.each do |w|
        digits << w.lines
        digits << w.words
        digits << w.bytes
      end
      digits.map { |d| d.to_s.length }.max
    end

    def format_number(num)
      num.to_s.rjust(@max_num_legth)
    end
  end
end
