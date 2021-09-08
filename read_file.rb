# frozen_string_literal: true

module Read
  def high_temp_file_loop(loop_var, array, file)
    file_loop = file[loop_var][1].to_i
    if file_loop > array[0]
      array[0] = file_loop
      array[1] = file[loop_var][0]
    elsif file_loop < array[6]
      array[6] = file_loop
    end
    [array, file]
  end

  def low_temp_file_loop(loop_var, array, file)
    file_loop = file[loop_var][3].to_i
    if file_loop < array[2]
      array[2] = file_loop
      array[3] = file[loop_var][0]
    elsif file_loop < array[7]
      array[7] = file_loop
    end
    [array, file]
  end

  def humid_file_loop(loop_var, array, file)
    file_loop = file[loop_var][7].to_i
    if file_loop > array[4]
      array[4] = file_loop
      array[5] = file[loop_var][0]
    elsif file_loop < array[8]
      array[8] = file_loop
    end
    [array, file]
  end

  def case_read_file(path, link)
    line_count = `wc -l "#{link}"`.strip.split(' ')[0].to_i
    case path
    when 'lahore_weather/lahore_weather'
      loop_var = 2
      line_count = line_count.to_i - 2
    else
      loop_var = 1
      line_count = line_count.to_i - 1
    end
    [loop_var, line_count]
  end

  # Function reading a file 1 time
  def read_files(year, month, path)
    array = [0, '', 100, '', 0, '', 100, 100, 100]
    month_name = Date::MONTHNAMES[month]
    link = "#{path}_#{year}_#{month_name[0..2]}.txt"
    file = CSV.read(link)
    loop_var, line_count = case_read_file(path, link)
    until loop_var > line_count
      high_temp_file_loop(loop_var, array, file)
      low_temp_file_loop(loop_var, array, file)
      humid_file_loop(loop_var, array, file)
      loop_var += 1
    end
    array
  end
end
