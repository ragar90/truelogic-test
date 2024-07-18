data = File.readlines("w_data.dat").map { |line|
  data_line = line.lstrip
  if data_line
    day = data_line[0..1].to_i
    max_temp_start_index = day < 10 ? 8 : 9
    min_temp_start_index = max_temp_start_index
    min_temp_end_index = min_temp_start_index + 6
    max_temp = (data_line[2..max_temp_start_index]&.strip&.gsub("*", "") || 0.0).to_f
    min_temp = (data_line[min_temp_start_index..min_temp_end_index]&.strip&.gsub("*", "") || 0.0).to_f
    {
      day: day,
      max_temp: max_temp,
      min_temp: min_temp,
      temp_spread: max_temp - min_temp
    }
  end
}
.reject { |temp_data| temp_data[:day].zero?}
.sort { |d1, d2| d1[:temp_spread] <=> d2[:temp_spread] }
puts "The Smallest temperature spread day is:\n
Day #{data[0][:day]}\n
with max temperatue of: #{data[0][:max_temp]}°\n
min temperatue of: #{data[0][:min_temp]}°\n
and spread of: #{data[0][:temp_spread]}°"
