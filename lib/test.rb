class Test
  def initialize
    @questions = read_questions
    @variants = read_variants
    @keys = read_keys

    @counter = 1 # номер текущего вопроса

    @questions_number = @questions.size # количество вопросов

    @score = 0 # количество набранных баллов
  end

  # считать вопросы для теста из файла
  def read_questions
    begin
      File.readlines(__dir__ + "/" + "../data/questions.txt", chomp: true, encoding: "UTF-8")
    rescue Errno::ENOENT
      abort "Файл с вопросами не найден"
    end
  end

  # считать варианты ответов из файла
  def read_variants
    begin
      File.readlines(__dir__ + "/" + "../data/variants.txt", chomp: true,  encoding: "UTF-8").map { |variant| variant.split("|") }
    rescue Errno::ENOENT
      abort "Файл с вариантами ответов не найден"
    end
  end

  # считать ключи из файла - массив целых чисел
  def read_keys
    begin
      File.readlines(__dir__ + "/" + "../data/keys.txt", chomp: true,  encoding: "UTF-8").map { |key| key.split(",").map(&:to_i) }
    rescue Errno::ENOENT
      abort "Файл с ключами на вопросы не найден"
    end
  end

  # закончена ли игра?
  def finished?
    @counter >= @questions_number
  end

  # напечатать слеюдующий вопрос
  def print_next_question
    puts @questions[@counter]
  end

  # напечатать список вариантов ответа на текущий вопрос
  def print_variants
    number = 0
    @variants[@counter].each { |variant| puts "#{number += 1}. #{variant}" }
  end

  # проверка на правильность ответа
  # вопросы, где можно дать несколько вариантов ответа, учтены
  # например, на 9-ый вопрос верным будет ответ "1,3,4", "4,1,3" и т.д.
  def good_answer?(answer)
    answer = answer.split(",").map(&:to_i)
    @keys[@counter].permutation.to_a.include?(answer) # учтены всевозможные комбинации правильных ответов
  end

  # обработка введенного ответа
  def process_answer(answer)
    if good_answer?(answer)
      @score += 1
    end
    @counter += 1
  end

  # вывод результата игры
  def print_result(start, finish)
    result = case @score
             when 0..2 then 'С логикой у вас очень слабо'
             when 3..6 then 'Логика не отсутствует, но, наверное, имеет смысл её ' \
               'потренировать.'
             when 7..10 then 'Вполне приемлемый результат, говорящий о нормально ' \
               'развитых логических способностях'
             when 11..12 then 'Говорят о хорошо развитых логических ' \
               'способностях. Вас трудно убедить речами, в которых есть ' \
               'логические неувязки. Вы видите многие ситуации «насквозь» ' \
               'и можете «предсказывать» поведение людей из вашего окружения'
             end

    if (finish - start)/60 > 8
      puts "К сожалению, вы не уложились в 8 минут"
    else
      puts "Вы уложились в 8 минут"
    end

    puts "Ваш результат: #{@score}"
    puts result
  end
end