require_relative 'post'
require_relative 'memo'
require_relative 'link'
require_relative 'task'

require 'optparse'

options = {}

OptionParser.new do |opt|
  opt.banner = 'Usage: read.rb [options]'

  opt.on('-h', 'Prints this help') do
    puts opt
    exit
  end

  opt.on('--type POST_TYPE', 'какой тип постов показывать (по умолчанию любой)') { |o| options[:type] = o } #
  opt.on('--id POST_ID', 'если задан id - показываем подробно только этот пост') { |o| options[:id] = o } #
  opt.on('--limit NUMBER', 'сколько последних постов показать (по умолчанию все)') { |o| options[:limit] = o }
end.parse!

if !options[:id].nil?
  result = Post.find_by_id(options[:id])

  puts "Запись #{result.class.name}, id = #{options[:id]}"

  result.to_strings.each do |line|
    puts line
    end
else
  result = Post.find(options[:limit], options[:type])

  print "|id\t| @type\t| @created_at\t\t\t| @text\t\t\t| @url\t\t| @due_date\t "
  result.each do |row|
    puts

    row.each do |element|
      print "| #{element.to_s[0..40]}\t"
    end
  end
end

puts

