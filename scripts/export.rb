#!/usr/bin/env ruby -w

require 'rubygems'
require 'sqlite3'

DB = SQLite3::Database.new('emoji_db_mountain_lion.sqlite')

show_missing = ARGV.include?('-m')
skip_output = ARGV.include?('-s')

codes = "_codes = @{\n"
emojis = "_emojis = @{\n"

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
  
  emojis << "#{objc} : #{code},\n"
  codes << "#{code} : #{objc},\n"
end

codes << "};"
emojis << "};"

if !skip_output
 puts codes
 puts
end

# puts "\n"
# puts emojis

if show_missing
  puts "---\nMissing emoji (#{missing.count}):"
  puts missing
end