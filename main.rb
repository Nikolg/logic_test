# encoding: utf-8
#
# Тест на абстрактное логическое мышление
#
name = ARGV[0]
# Выводим приветствие
puts "Привет, #{name.encode('UTF-8')}" if name
puts 'Тест на логику вашего мышления. У вас есть 8 минут на 12 вопросов!'

questions = File.readlines(__dir__ + "/" + "data/questions.txt", chomp: true)

variants = File.readlines(__dir__ + "/" + "data/variants.txt", chomp: true)
variants.map! { |variant| variant.split("|") }

keys = File.readlines(__dir__ + "/" + "data/keys.txt", chomp: true)
keys.map! { |key| key.split(",")}

test = Test.new

until test.completed?

end



puts questions.inspect
puts
puts variants.inspect
puts
puts keys.inspect