#!/usr/bin/env ruby -w

require 'rubygems'
require 'sqlite3'

DIR = File.dirname(__FILE__)
DB = SQLite3::Database.new(DIR + '/../data/emoji.sqlite')

show_missing = ARGV.include?('-m')
skip_output = ARGV.include?('-s')

codes = "[NSDictionary dictionaryWithObjectsAndKeys:\n"

rows = DB.execute('SELECT * FROM emoji ORDER BY code ASC');

missing = []

rows.each do |row|
  raw_code = row[0].chomp
  
  code = "@\":#{raw_code}:\""
  unicode = row[2]
  
  if unicode.nil?
    missing << raw_code
    next
  end

  objc = ""

  if unicode.length == 5
    objc = "@\"\\U000#{unicode}\""
  elsif unicode.length == 4
    objc = "@\"\\u#{unicode}\""
  elsif unicode.length == 9
    parts = unicode.split(' ')
    objc = "[NSString stringWithFormat:@\"%C%C\", (unichar)0x#{parts[0]}, (unichar)0x#{parts[1]}]"
  elsif unicode.length == 11
    parts = unicode.split(' ')
    objc = "[NSString stringWithFormat:@\"\\U000#{parts[0]}\\U000#{parts[1]}\"]"
  elsif unicode.length == 19
    parts = unicode.split(' ')
    objc = "[NSString stringWithFormat:@\"%C%C%C%C\", (unichar)0x#{parts[0]}, (unichar)0x#{parts[1]}, (unichar)0x#{parts[2]}, (unichar)0x#{parts[3]}]"
  else
    puts "*** Unhandled unicode: #{unicode}"
    exit()
  end
  
  codes << "#{objc}, #{code},\n"
  # New dictionary literal syntax
  # codes << "#{code} : #{objc},\n"
end

codes << "nil];"
# codes << "};"

if !skip_output
 puts codes
 puts
end

if show_missing
  puts "---\nMissing emoji (#{missing.count}):"
  puts missing
end