# frozen_string_literal: true

require './read_file'

class Month
  include Read
  def initialize; end

  def output_month(array)
    puts("Highest Average: #{array[0]}C")
    puts("Lowest Average: #{array[2]}C")
    puts("Average Humidity: #{array[4]}%")
  end

  def month(year, path)
    year = year.split('/')
    month = year[1].to_i
    highest = read_files(year[0], month, path)
    output_month(highest)
  end
end
