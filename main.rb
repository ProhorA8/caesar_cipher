class CaesarCipher
  # создадим метод геттер для извлечение результата
  attr_reader :result

  def initialize
    check_input
    @result = receives_ciphertext
  end

  # проверка количества переданных аргументов
  def check_input
    if ARGV.length != 2
      puts 'Нам нужно ровно два аргумента'
      exit
    end
  end

  # получение содержимого файла
  def read_file
    file = File.open(ARGV[0], 'r')
    @file_text = file.readline
    file.close
  rescue TypeError
    puts 'Вы не передали файл!'
  end

  # получает зашифрованый текст
  def receives_ciphertext
    read_file
    offset = ARGV[1].to_i
    @file_text.chars.map do |letter|
      # h / H
      case letter
      when 'a'..'z'
        # ('h', 97, 3)
        encryption(letter, 'a'.ord, offset)
      when 'A'..'Z'
        # ('H', 65, 3)
        encryption(letter, 'A'.ord, offset)
      else
        letter
      end
    end.join
  end

  private

  # шифрует букву с заданным сдвигом
  def encryption(letter, position, offset)
    # ((104 - 97) + 3) % 26 + 97 = 107.chr => 'k'
    # ((72 - 65) + 3) % 26 + 65 = 75.chr => 'K'
    (((letter.ord - position) + offset) % 26 + position).chr
  end
end

# выведем в консоль результат
puts CaesarCipher.new.result
