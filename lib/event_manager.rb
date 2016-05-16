require 'csv'
require 'sunlight/congress'

Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"

@contents = CSV.open "../event_attendees.csv", headers: true, header_converters: :symbol

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5,'0')[0..4]
end

def legislators_by_zipcode(zipcode)
  legislators = Sunlight::Congress::Legislator.by_zipcode(zipcode)
  legislators.collect { |legislator| legislator.first_name + " " + legislator.last_name }
end

def print_name_zipcodes
  puts "EventManager initialized."
  @contents.each do |row|
    name = row[:first_name].ljust(12)
    zipcode = clean_zipcode(row[:zipcode])

    legislators = legislators_by_zipcode(zipcode)
    puts "#{name} #{zipcode} #{legislators}"
  end
end

# p legislators_by_zipcode("68787")
puts print_name_zipcodes
