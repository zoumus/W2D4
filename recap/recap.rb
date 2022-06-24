def no_dupes?(arr)
    new_a = []
    h = Hash.new(0)
    arr.each { |el| h[el] += 1}
    h.each do |k, v|
        new_a << k if h[k] == 1
    end
    new_a
end
# p no_dupes?([1, 1, 2, 1, 3, 2, 4])         # => [3, 4]
# p no_dupes?(['x', 'x', 'y', 'z', 'z'])     # => ['y']
# p no_dupes?([true, true, true])            # => []

def no_consecutive_repeats?(arr)
    arr.each_with_index do |el, i|
        return false if arr[i] == arr[i + 1]
    end
    true
end
# p no_consecutive_repeats?(['cat', 'dog', 'mouse', 'dog'])     # => true
# p no_consecutive_repeats?(['cat', 'dog', 'dog', 'mouse'])     # => false
# p no_consecutive_repeats?([10, 42, 3, 7, 10, 3])              # => true
# p no_consecutive_repeats?([10, 42, 3, 3, 10, 3])              # => false
# p no_consecutive_p repeats?(['x'])                              # => true


def char_indices(str)
    hash = Hash.new{ |h, k| h[k] = []}

    str.each_char.with_index do |char, i|
        hash[char] << i
    end
    hash
end
# p char_indices('mississippi')   # => {"m"=>[0], "i"=>[1, 4, 7, 10], "s"=>[2, 3, 5, 6], "p"=>[8, 9]}
# p char_indices('classroom')     # => {"c"=>[0], "l"=>[1], "a"=>[2], "s"=>[3, 4], "r"=>[5], "o"=>[6, 7], "m"=>[8]}

def longest_streak(str)
    current_s = ''
    longest_s = ''
    return str if str.length == 1

    i = 0
    while i < str.length - 1
        el_1 = str[i]
        el_2 = str[i + 1]
        if el_1 == el_2
            current_s += el_2
        else 
            current_s = el_2
        end
        if current_s.length >= longest_s.length
            longest_s = current_s
        end
        
        i += 1
    end
    longest_s
end

# p longest_streak('a')           # => 'a'
# p longest_streak('accccbbb')    # => 'cccc'
# p longest_streak('aaaxyyyyyzz') # => 'yyyyy
# p longest_streak('aaabbb')      # => 'bbb'
# p longest_streak('abc')         # => 'c'

def bi_prime?(num)
    (2...num).each do |i|
        (2..num).each do |j|
            if i * j == num && is_prime?(i) && is_prime?(j)
                return true
            end
        end
    end
    false
end
def is_prime?(n)
    (2...n).none? { |el| n % el == 0}
end

# p bi_prime?(14)   # => true
# p bi_prime?(22)   # => true
# p bi_prime?(25)   # => true
# p bi_prime?(94)   # => true
# p bi_prime?(24)   # => false
# p bi_prime?(64)   # => false

def vigenere_cipher(message, keys)
    new_s = ''
    alpha = ("a".."z").to_a
    message.each_char.with_index do |char, i|
        old_idx = alpha.index(char)
        key = keys[i % keys.length]
        new_idx = old_idx + key
        new_s += alpha[new_idx % alpha.length]
    end
    new_s
end
# p vigenere_cipher("toerrishuman", [1])        # => "upfssjtivnbo"
# p vigenere_cipher("toerrishuman", [1, 2])     # => "uqftsktjvobp"
# p vigenere_cipher("toerrishuman", [1, 2, 3])  # => "uqhstltjxncq"
# p vigenere_cipher("zebra", [3, 0])            # => "ceerd"
# p vigenere_cipher("yawn", [5, 1])             # => "dbbo"

def vowel_rotate(str)
    new_s = str[0..-1]
    vow_indices = word_indices(str)
    new_vow_indices = vow_indices.rotate(-1)
    vow_indices.each_with_index do |vow_idx, i|
        new_s[vow_idx] = str[new_vow_indices[i]]
    end
    new_s
end


def word_indices(str)
    indices = []
    (0...str.length).each do |i|
        if 'aeiou'.include?(str[i])
        indices << i
        end
    end
    indices
end

# p vowel_rotate('computer')      # => "cempotur"
# p vowel_rotate('oranges')       # => "erongas"
# p vowel_rotate('headphones')    # => "heedphanos"
# p vowel_rotate('bootcamp')      # => "baotcomp"
# p vowel_rotate('awesome')       # => "ewasemo"
class String

    def select(&prc)
        new_s = ''
        return '' if prc == nil
        self.each_char do |ch|
            new_s += ch if prc.call(ch)
        end
        new_s
    end

    def map!(&prc)
        self.each_char.with_index do |ch, i|
            self[i] = prc.call(ch, i)
        end
        self
    end

end
# p "app academy".select { |ch| !"aeiou".include?(ch) }   # => "pp cdmy"
# p "HELLOworld".select { |ch| ch == ch.upcase }          # => "HELLO"
# p "HELLOworld".select          # => ""


def multiply(a, b)
    return 0 if b == 0
    if b > 0
        a + multiply(a, (b - 1))
    else
        -(a + multiply(a, (-b - 1)))
    end
    
end
# p multiply(3, 5)        # => 15
# p multiply(5, 3)        # => 15
# p multiply(2, 4)        # => 8
# p multiply(0, 10)       # => 0
# p multiply(-3, -6)      # => 18
# p multiply(3, -6)       # => -18
# p multiply(-3, 6)       # => -18

def lucas_sequence(num)
    return [] if num == 0
    return [2] if num == 1
    return [2, 1] if num == 2

    arr = lucas_sequence(num - 1)
    last_el = arr[-1] + arr[-2]
    arr << last_el
    arr
end

p lucas_sequence(0)   # => []
p lucas_sequence(1)   # => [2]    
p lucas_sequence(2)   # => [2, 1]
p lucas_sequence(3)   # => [2, 1, 3]
p lucas_sequence(6)   # => [2, 1, 3, 4, 7, 11]
p lucas_sequence(8)   # => [2, 1, 3, 4, 7, 11, 18, 29]














