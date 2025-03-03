require "csv"
require "google/apis/civicinfo_v2"
require "erb"

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, "0")[0..4]
end

def clean_phone_number(phone_number)
  return nil unless phone_number.is_a?(String)

  digits = phone_number.gsub(/\D/, "")

  case digits.length
  when 10
    "#{digits[0..2]}-#{digits[3..5]}-#{digits[6..9]}"
  when 11
    digits[0] == "1" ? "#{digits[1..3]}-#{digits[4..6]}-#{digits[7..10]}" : nil
  end
end

def time_targeting(timestamps)
  hours = timestamps.map { |ts| ts.split.last.split(":").first.to_i }
  frequency = hours.tally

  max_count = frequency.values.max
  mode_hours = frequency.select { |hour, count| count == max_count }.keys

  # puts frequency
  mode_hours.sort
end

def find_weekday(timestamps)
  require "date"

  days_of_week = timestamps.map do |ts|
    parts = ts.split
    date_part = parts[0]

    month, day, year = date_part.split("/")

    year = "20#{year}" if year.length == 2

    date = Date.new(year.to_i, month.to_i, day.to_i)

    date.strftime("%A")
  end

  frequency = days_of_week.tally

  max_count = frequency.values.max

  mode_days = frequency.select { |day, count| count == max_count }.keys

  mode_days.sort
end

def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = "AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw"

  begin
    civic_info.representative_info_by_address(
      address: zip,
      levels: "country",
      roles: %w[legislatorUpperBody legislatorLowerBody]
    ).officials
  rescue StandardError
    "You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials"
  end
end

def save_thank_you_letter(id, form_letter)
  output_dir = "Ruby/event_manager/lib/output"

  FileUtils.mkdir(output_dir) unless Dir.exist?(output_dir)

  filename = File.join(output_dir, "thanks_#{id}.html")

  File.open(filename, "w") do |file|
    file.puts form_letter
  end
end

puts "EventManager initialized."

contents = CSV.open(
  "./Ruby/event_manager/event_attendees.csv",
  headers: true,
  header_converters: :symbol
)

template_letter = File.read("./Ruby/event_manager/form_letter.erb")
erb_template = ERB.new template_letter

regdates = []
contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  legislators = legislators_by_zipcode(zipcode)

  # phone number method, ready for appropriate implementation
  phone_number = clean_phone_number(row[:homephone])
  # puts phone_number

  regdates.push(row[:regdate])
  form_letter = erb_template.result(binding)

  save_thank_you_letter(id, form_letter)
end
puts time_targeting(regdates)
puts find_weekday(regdates)
