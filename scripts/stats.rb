#!/usr/bin/env ruby -w

require 'rubygems'

DIR = File.dirname(__FILE__)

rows = File.open(DIR + '/../data/emoji.csv').readlines
rows.shift # First row is column names, ignore that

# emoji codes that don't have a unicode representation
missing = []
emoji = []

rows.each do |row|
  parts = row.chomp.split(',')
  raw_code = parts[0].strip
  code = ":#{raw_code}:"
  unicode = parts[1].nil? ? nil : parts[1].strip

  if unicode.nil?
    missing << code
  end

  emoji << code
end

puts "---\nTotal emoji: #{emoji.count}\n"

puts "---\nMissing emoji (no unicode): #{missing.count}"
puts missing
