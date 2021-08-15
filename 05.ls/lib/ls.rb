# frozen_string_literal: true

module LS
  def self.generate_path_list(path)
    ls = []
    Dir.foreach(path) do |entry|
      ls << File.join(path, entry)
    end

    ls
  end
end
