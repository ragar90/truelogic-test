SIGN_ENUMS = [:FOR, :AGAINST]
SIGN_ENUMS.freeze
index = 0
data = File.readlines("soccer.dat").map { |line|
  data_line = line.lstrip
  agg = if data_line && index > 2
    name = data_line[0..18]&.strip.gsub(/(\d{1,2}\.\s|-+|<\/\w+>)/, "")
    goals_for = (data_line[38..45]&.gsub("-", "")&.strip&.to_i || 1_000_000)
    goals_against = (data_line[46..51]&.gsub("-", "")&.strip&.to_i || 1_000_000)
    # max_temp_start_index = day < 10 ? 8 : 9
    # min_temp_start_index = max_temp_start_index
    # min_temp_end_index = min_temp_start_index + 6
    # max_temp = (data_line[2..max_temp_start_index]&.strip&.gsub("*", "") || 0.0).to_f
    # min_temp = (data_line[min_temp_start_index..min_temp_end_index]&.strip&.gsub("*", "") || 0.0).to_f
    {
      team_name: name,
      for: goals_for,
      against: goals_against,
      diff: (goals_for - goals_against).abs,
      sign: (goals_for - goals_against) > 0 ? SIGN_ENUMS[0] : SIGN_ENUMS[1]
    }
  end
  index += 1
  agg
}
.reject { |temp_data| temp_data.nil? || temp_data[:team_name].empty? }
.sort { |d1, d2| d1[:diff] <=> d2[:diff] }

puts "The Team with the smallest difference in goas is #{data[0][:team_name]} with #{data[0][:diff]} #{data[0][:sign].to_s.downcase} them"
