# frozen_string_literal: true

module WC
  def self.read_files(paths)
    paths.map { |path| File.readlines(path) }
  end
end
