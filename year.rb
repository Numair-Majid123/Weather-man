# frozen_string_literal: true

require './read_file'

class Year
  def initialize; end
  include Read
  def year_loop_first(array, highest)
    if array[0] < highest[0]
      array[0] = highest[0]
      array[3] = highest[1]
    end
    [array, highest]
  end

  def year_loop_second(array, highest)
    if array[1] > highest[2]
      array[1] = highest[2]
      array[4] = highest[3]
    end
    [array, highest]
  end

  def year_loop_third(array, highest)
    if array[2] < highest[4]
      array[2] = highest[4]
      array[5] = highest[5]
    end
    [array, highest]
  end

  def split_date(array)
    array.split('-')
  end

  def change_month(date)
    Date::MONTHNAMES[date.to_i]
  end

  def output_year(array)
    max_temp_date = split_date(array[3])
    min_temp_date = split_date(array[4])
    humid_date = split_date(array[5])
    max_date = change_month(max_temp_date[1])
    min_date = change_month(min_temp_date[1])
    humid_dat = change_month(humid_date[1])
    puts("Highest: #{array[0]}C on #{max_date} #{max_temp_date[2]}")
    puts("Lowest: #{array[1]}C on #{min_date} #{min_temp_date[2]}")
    puts("Humid: #{array[2]}% on #{humid_dat} #{humid_date[2]}")
  end

  def year_loop(array, highest)
    year_loop_first(array, highest)
    year_loop_second(array, highest)
    year_loop_third(array, highest)
    [array, highest]
  end

  def year(year, path)
    array = [0, 100, 0, '', '', '']
    loop_var = 1
    while loop_var <= 12
      highest = read_files(year, loop_var, path)
      year_loop(array, highest)
      loop_var += 1
    end
    output_year(array)
  end
end
