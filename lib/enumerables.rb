# rubocop:disable Metrics/PerceivedComplexity
# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/ModuleLength
# rubocop:disable Metrics/MethodLength
# rubocop:disable Lint/ToEnumArguments

module Enumerable
  # 3.
  def my_each
    if block_given?
      length.times do |idx|
        yield(self[idx])
      end
      self
    else
      to_enum(__method__)
    end
  end

  # 4.
  def my_each_with_index
    if block_given?
      length.times do |idx|
        yield(self[idx], idx)
      end
      self
    else
      to_enum(__method__)
    end
  end

  # 5.
  def my_select
    if block_given?
      ary = []
      my_each do |e|
        ary << e if yield(e)
      end
      ary
    else
      to_enum(__method__)
    end
  end

  # 6.
  def my_all?(word = nil)
    all = true

    my_type = lambda do |f|
      my_each do |r|
        unless r.instance_of?(f)
          all = !all
          break
        end
      end
      all
    end

    if block_given? && word.nil?
      my_each do |e|
        unless yield(e)
          all = !all
          break
        end
      end
      all
    elsif !block_given?
      if word == Regexp
        my_each do |e|
          if e != word
            all = !all
            break
          end
        end
        all
      elsif word == Numeric
        my_each do |e|
          unless e.is_a? word
            all = !all
            break
          end
        end
        all
      elsif word == Integer
        my_type.call(Integer)
      elsif word == Float
        my_type.call(Float)
      elsif word == Symbol
        my_type.call(Symbol)
      elsif word == String
        my_type.call(String)
      elsif word.instance_of?(Regexp)
        my_each do |e|
          unless word.match(e)
            all = !all
            break
          end
        end
        all
      elsif word.nil?
        my_each do |e|
          if !e || e.nil?
            all = !all
            break
          end
        end
        all
      elsif empty?
        all
      end
    else
      to_enum(__method__)
    end
  end

  # 7.
  def my_any?(word = nil)
    any = false

    my_type1 = lambda do |j|
      my_each do |d|
        if d.instance_of?(j)
          any = !any
          break
        end
      end
      any
    end

    if block_given? && word.nil?
      my_each do |e|
        if yield(e)
          any = !any
          break
        end
      end
      any
    elsif !block_given?
      if word == Regexp || word.instance_of?(Regexp)
        my_each do |e|
          if e == Regexp || e.instance_of?(Regexp)
            any = !any
            break
          end
        end
        any
      elsif word == Numeric
        my_each do |e|
          if e.is_a? word
            any = !any
            break
          end
        end
        any
      elsif word == Integer
        my_type1.call(Integer)
      elsif word == Float
        my_type1.call(Float)
      elsif word == Symbol
        my_type1.call(Symbol)
      elsif word.nil?
        my_each do |e|
          if e
            any = !any
            break
          end
        end
        any
      elsif empty?
        any
      end
    else
      to_enum(__method__)
    end
  end

  # 8.
  def my_none?(word = nil)
    none = true

    my_type2 = lambda do |v|
      my_each do |y|
        if y.instance_of?(v)
          none = !none
          break
        end
      end
      none
    end

    if block_given? && word.nil?
      my_each do |e|
        if yield(e)
          none = !none
          break
        end
      end
      none
    elsif !block_given?
      if word == Regexp || word.instance_of?(Regexp)
        my_each do |e|
          if e == word || e.instance_of?(Regexp)
            none = !none
            break
          end
        end
        none
      elsif word == Numeric
        my_each do |e|
          if e.is_a? word
            none = !none
            break
          end
        end
        none
      elsif word == Integer
        my_type2.call(Integer)
      elsif word == Float
        my_type2.call(Float)
      elsif word == Symbol
        my_type2.call(Symbol)
      elsif word.nil?
        each do |e|
          if e
            none = !none
            break
          end
        end
        none
      elsif empty?
        none
      end
    else
      to_enum(__method__)
    end
  end

  # 9.
  def my_count(num = nil)
    count = 0
    if block_given? && num.nil?
      return 'A block is passed and there are no elements in your array' if empty?

      my_each do |e|
        count += 1 if yield(e)
      end
      count
    elsif !block_given?
      if num.instance_of?(Integer)
        return 'The argument is an Integer and there are no elements in your array' if empty?

        return count if num.negative?

        count = num
      elsif num.instance_of?(Float) || empty?
        count
      elsif num.nil? && empty? || num.nil?
        count = length
      end
    else
      to_enum(__method__)
    end
  end

  # 10.
  def my_map
    arr = nil
    my_type = lambda do
      arr = instance_of?(Array) ? self : to_a
    end
    my_type.call

    if block_given?
      ary = []
      arr.my_each do |e|
        ary << yield(e)
      end
      ary
    else
      to_enum(__method__)
    end
  end

  # 11.
  def my_inject(arg = nil)
    arr = nil

    my_type = lambda do
      arr = instance_of?(Array) ? self : to_a
    end
    my_type.call

    if block_given?
      if arg.nil?
        acc = 0
        acc = arr[acc] if arr.my_all?(String)
      else
        acc = arg
      end
      arr.my_each do |e|
        acc = yield(acc, e)
      end
      acc
    else
      to_enum(__method__)
    end
  end

  # 13.
  def my_map_proc(proc_arg = nil)
    arr = nil
    my_type = lambda do
      arr = instance_of?(Array) ? self : to_a
    end
    my_type.call

    if proc_arg.instance_of? Proc
      ary = []
      arr.my_each do |e|
        ary << proc_arg.call(e)
      end
      ary
    else
      to_enum(__method__)
    end
  end

  # 14.
  def my_map_proc_or_block(proc_arg = nil, &block)
    arr = nil
    my_type = lambda do
      arr = instance_of?(Array) ? self : to_a
    end
    my_type.call

    return to_enum(__method__) if proc_arg.instance_of? Proc and block

    if proc_arg.instance_of? Proc
      ary = []
      arr.my_each do |e|
        ary << proc_arg.call(e)
      end
      ary
    elsif block
      ary = []
      arr.my_each do |e|
        ary << block.call(e)
      end
      ary
    else
      to_enum(__method__)
    end
  end
end

# 12.
def multiply_els(val = nil)
  my_type = lambda do |elem|
    elem.instance_of?(Array) ? elem : elem.to_a
  end

  if block_given? && !val.nil?
    arr1 = my_type.call(val)
    acc = 1
    arr1.my_inject do |_s, e|
      acc = yield(acc, e)
    end
    acc
  else
    to_enum(__method__)
  end
end

# rubocop:enable Lint/ToEnumArguments
# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/ModuleLength
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/PerceivedComplexity

# TEST SAMPLES AND ANSWERS
# TURN OFF COMMENT ON arr(LINE 441 to LINE 443) AND USE THE SAMPLES BELOW TO TEST THE METHODS
# arr = [1, 2, 3, 4, 5]
# ary = [1, 2, 4, 2]
# ary = []

#---3---------------------MY EACH---------------------------
# arr.my_each { |e| puts e }                                  #=> 1, 2, 3, 4, 5
#-------------------------------------------------------------------------------

#---4--------------------MY EACH WITH INDEX------------------------
# arr.my_each_with_index { |v, i| puts "#{v} and #{i}" }      #=>1  and 0, 2 and 1, 3 and 2, 4 and 3, 5 and 4
#---------------------------------------------------------------------------

#---5-----------------------MY SELECT----------------------------
# p arr.my_select { |e| e != 2 }                              #=> [1, 3, 4, 5]
#----------------------------------------------------------------------------------

#---6------------------------MY ALL---------------------------------------
# puts arr.my_all? { |e| e == 2 }                             #=> false
# puts %w[ant bear cat].my_all? { |word| word.length >= 3 }   #=> true
# puts %w[ant bear cat].my_all? { |word| word.length >= 4 }   #=> false
# puts %w[ant bear cat].my_all?(/a/)                          #=> true
# puts [1, 2i, 3.14].my_all?(Numeric)                         #=> true
# puts [nil, true, 99].my_all?                                #=> false
# puts [].my_all?                                             #=> true
# puts [1, 2i, 3.14].my_all?(3) {|word| word == 3}            #=> err enumerable
#-----------------------------------------------------------------------------------

#---7-------------------------MY ANY---------------------------------
# puts %w[ant bear cat].my_any? { |word| word.length >= 3 }   #=> true
# puts %w[ant bear cat].my_any? { |word| word.length >= 4 }   #=> true
# puts %w[ant bear cat].my_any?(/d/)                          #=> false
# puts [nil, true, 99].my_any?(Integer)                       #=> true
# puts [nil, true, 99].my_any?                                #=> true
# puts [].my_any?                                             #=> false
#---------------------------------------------------------------------------

#---8------------------------MY NONE-------------------------------
# puts %w[ant bear cat].my_none? { |word| word.length == 5 }  #=> true
# puts %w[ant bear cat].my_none? { |word| word.length >= 4 }  #=> false
# puts %w[ant bear cat].my_none?(/d/)                         #=> true
# puts [1, 3.14, 42].my_none?(Float)                          #=> false
# puts [].my_none?                                            #=> true
# puts [nil].my_none?                                         #=> true
# puts [nil, false].my_none?                                  #=> true
# puts [nil, false, true].my_none?                            #=> false
#--------------------------------------------------------------------------

#---9------------------------MY COUNT---------------------------------
# puts ary.my_count                                           #=> 4
# puts ary.my_count(2)                                        #=> 2
# puts ary.my_count(-2)                                       #=> 0
# puts ary.my_count{ |x| x%2==0 }                             #=> 3
# puts ary.my_count(2) { |x| x%2==0 }                         #=> <Enumerator:0x00007f800d143d10>

# --Results when ary array is empty--
# 0
# The argument is an Integer and there are no elements in your array
# The argument is an Integer and there are no elements in your array
# A block is passed and there are no elements in your array
# <Enumerator:0x00007feb100c7da0>
#-------------------------------------------------------------------------------------

#---10----------------------MY MAP-------------------------------------
# p arr.my_map { |e| e + 2 }                                  #=> [3, 4, 5, 6, 7]
#----------------------------------------------------------------------------------

#---11-----------------------MY INJECT-----------------------------
# puts arr.my_inject { |sum, n| sum + n }                     #=> 15
# puts (5..10).my_inject { |sum, n| sum + n }                 #=> 45
# puts (5..10).my_inject(2) { |sum, n| sum * n }              #=> 302400
# puts %w{ cat sheep bear }.my_inject { |memo, word| longest = memo.length > word.length ? memo : word }    #=> sheep
#-----------------------------------------------------------------------------------------------------

#---12------------------------MULTIPLY_ELS-------------------------
# puts multiply_els(arr) { |sum, n| sum * n }                 #=> 120
# puts multiply_els(5..10) { |sum, n| sum * n }               #=> 151200
#------------------------------------------------------------------------------------------------------

#---13----------------------PROC----------------------------------
# proc = Proc.new { |num| num * 4 }
# p arr.my_map_proc(proc)                                     #=> [4, 8, 12, 16, 20]

# p arr.my_map_proc { |num| num + 3 }                         #=> <Enumerator: [1, 2, 3, 4, 5]:my_map_proc>
#------------------------------------------------------------------------------------------

#---14---------------------PROC OR BLOCK-------------------------------------------
# proc = Proc.new { |num| num + 2 }
# p arr.my_map_proc_or_block(proc)                            #=> [3, 4, 5, 6, 7]

# p arr.my_map_proc_or_block { |num| num + 4 }                #=> [5, 6, 7, 8, 9]
#-------------------------------------------------------------------------------------------

#------------------------Proc and Block----
# proc = Proc.new { |num| num + 2 }
# p arr.my_map_proc_or_block(proc)

# p arr.my_map_proc_or_block(proc) { |num| num + 5 }
#-------------------------------------------------------
