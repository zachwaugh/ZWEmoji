#!/usr/bin/env ruby -w

require 'rubygems'

DIR = File.dirname(__FILE__)

rows = File.open(DIR + '/../data/emoji.csv').readlines

show_missing = ARGV.include?('-m')
skip_output = ARGV.include?('-s')

# build up NSDictionary of codes -> unicode
emoji = []

# emoji codes that don't have a unicode representation
missing = []

rows.each do |row|
  parts = row.chomp.split(',')
  raw_code = parts[0].strip
  code = "@\":#{raw_code}:\""
  unicode = parts[1].nil? ? nil : parts[1].strip

  objc = ""

  if unicode.nil?
    objc = code
    missing << raw_code
  elsif unicode.length == 5
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
  
  emoji << "#{code}: #{objc}"
end

dict = emoji.join(",\n")
nsdictionary = "@{#{dict}};"

if !skip_output
 puts nsdictionary
end

if show_missing
  puts "---\nMissing emoji (#{missing.count}):"
  puts missing
end