class Test
  def initialize
    clear_screen
    @questions = read_questions
    @variants = read_variants
    @keys = read_keys

    @counter = 0

    @questions_number = @questions.size

    @score = 0
  end

  def read_questions
    File.readlines(__dir__ + "/" + "../data/questions2.txt", chomp: true, encoding: "UTF-8")
  end

  def read_variants
    variants = File.readlines(__dir__ + "/" + "../data/variants.txt", chomp: true,  encoding: "UTF-8")
    variants.map! { |variant| variant.split("|") }
  end

  def read_keys
    keys = File.readlines(__dir__ + "/" + "../data/keys.txt", chomp: true,  encoding: "UTF-8")
    keys.map! { |key| key.split(",") }
  end

  def finished?
    @counter >= @questions_number
  end

  def print_next_question
    puts @questions[@counter]
  end

  def print_variants
    number = 0
    @variants[@counter].each { |variant| puts "#{number += 1}. #{variant}" }
  end

  def good_answer?(answer)
    answer == @keys[@counter]
  end

  def process_answer(answer)
    if good_answer?(answer)
      @score += 1
    end
    @counter += 1
  end

  def clear_screen
    system "cls" || "clear"
  end


end