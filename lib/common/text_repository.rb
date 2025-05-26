# frozen_string_literal: true

# Text Repository will save the connections to txt files in which data will be saved
class TextRepository
  def initialize(file_path)
    @file_path = file_path
  end

  def write(data)
    # `data` is expected to be a string
    File.open(@file_path, 'a') do |file|
      file.puts data
    end
  end

  def delete
    File.open(@file_path, 'w') do |file|
      file.puts ''
    end
  end

  def read
    return '' unless File.exist?(@file_path)

    File.read(@file_path)
  end
end
