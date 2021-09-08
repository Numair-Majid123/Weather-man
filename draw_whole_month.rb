# frozen_string_literal: true

class Draw
  def initialize; end

  def draw_month(day, high_temp, low_temp)
    i = 0
    print day
    while i < low_temp.to_i
      print '+'.blue
      i += 1
    end
    i = 0
    while i < high_temp.to_i
      print '+'.red
      i += 1
    end
    print low_temp, 'C - ', high_temp, 'C'
    puts ' '
  end

  def draw_original(path, file, link)
    line_count = `wc -l "#{link}"`.strip.split(' ')[0].to_i
    case path
    when 'lahore_weather/lahore_weather'
      loop_var = 2
      line_count = line_count.to_i - 2
    else
      loop_var = 1
      line_count = line_count.to_i - 1
    end
    date = 1
    until loop_var > line_count
      draw_month(date, file[loop_var][1], file[loop_var][3])
      loop_var += 1
      date += 1
    end
  end

  def draw_whole_month(year, path)
    year = year.split('/')
    month = year[1].to_i
    month_name = Date::MONTHNAMES[month]
    link = "#{path}_#{year[0]}_#{month_name[0..2]}.txt"
    file = CSV.read(link)
    draw_original(path, file, link)
  end
end
