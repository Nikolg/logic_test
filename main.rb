# encoding: utf-8
#
# Тест на абстрактное логическое мышление

require_relative __dir__ + "/" + "lib/test.rb"

name = ARGV[0]
name = "Гость" if !nil || nil == ""

# Выводим приветствие
puts "Привет, #{name.encode('UTF-8')}"
puts 'Тест на логику вашего мышления. У вас есть 8 минут на 12 вопросов!'

test = Test.new

start = Time.now

until test.finished?
  test.print_next_question
  test.print_variants

  print "Ответ: "
  test.process_answer(STDIN.gets.chomp)
  puts
end

test.print_result(start, Time.now)