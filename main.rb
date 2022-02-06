class CaesarCipher
  def initialize(file_path, key)
    @file_path = file_path
    @key = key
  end

  # проверка количества переданных аргументов
  def check_input
    if method(:initialize).arity != 2
      puts 'Нам нужно ровно два аргумента'
      exit
    end
  end

  # получение содержимого файла
  def read_file
    file_path = @file_path
    file = File.open(file_path, 'r')
    file_text = file.readline
    file.close
    file_text
  rescue TypeError
    puts 'Вы не передали файл!'
  end

  # возвращает зашифрованный текст
  def encryption
    text = read_file
    key = @key
    receives_ciphertext text, key
  end

  # возвращает исходный текст
  def decoding
    text = encryption
    # делаем ключ отрицательным
    key = @key * -1
    receives_ciphertext text, key
  end

  private

  # отвечает за шифрование/расшифровки текста
  def receives_ciphertext(file_text, offset)
    file_text.chars.map do |letter|
      # h / H
      case letter
      when 'a'..'z'
        # ('h', 97, 3)
        encryption_letter(letter, 'a'.ord, offset)
      when 'A'..'Z'
        # ('H', 65, 3)
        encryption_letter(letter, 'A'.ord, offset)
      else
        letter
      end
    end.join
  end

  # шифрует букву с заданным сдвигом
  def encryption_letter(letter, position, offset)
    # ((104 - 97) + 3) % 26 + 97 = 107.chr => 'k'
    # ((72 - 65) + 3) % 26 + 65 = 75.chr => 'K'
    (((letter.ord - position) + offset) % 26 + position).chr
  end
end

file_path = ARGV[0]
key = ARGV[1].to_i

cipher = CaesarCipher.new(file_path, key)
puts cipher.encryption
puts cipher.decoding
