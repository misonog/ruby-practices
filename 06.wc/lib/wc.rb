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
end
