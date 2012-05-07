# Copyright (C) 2011  Kenichi Kamiya

class Integer; module Base
  
  class << self

    # @param [#to_str] str
    # @param [Array<#to_sym>] chars
    # @return [Integer]
    def parse(str, chars)
      chars = base_chars_for chars
      str   = str.to_str.downcase
      
      sign  = parse_sign! str
      trim_paddings! str, chars.first
      
      abs = parse_abs str, chars
      
      (sign == :-) ? -abs : abs       
    end

    # @param [#to_int] num
    # @param [Array<#to_sym>] chars
    # @return [String]
    def convert_to_string(num, chars)
      chars = base_chars_for chars
      int   = num.to_int
      base  = chars.length
      
      return chars.first.to_s if int == 0

      ''.tap {|s|
        n = int.abs

        until (n, excess = n.divmod base; n == 0 && excess == 0)
          s << chars[excess].to_s
        end
        
        s.reverse!
        s.insert 0, '-' if int < 0
      }
    end
    
    private
    
    # @param [Array<#to_sym>] chars
    # @return [Array<Symbol>]
    def base_chars_for(chars)
      chars = chars.map{|c|c.downcase.to_sym}

      case
      when chars.length < 2
        raise TypeError, 'use 2 and more characters'
      when chars.dup.uniq!
        raise InvalidCharacter, 'dupulicated characters'
      when chars.any?{|s|(! s.kind_of?(Symbol)) || (s.length != 1)}
        raise InvalidCharacter, 'chars must be Array<Char> (Char: String & length 1)'
      when chars.any?{|c|SPECIAL_CHAR =~ c}
        raise InvalidCharacter, 'included Special Characters (-, +, space, control-char)'
      else
        chars
      end
    end
    
    # @return [Symbol]
    def parse_sign!(str)
      sign = str.slice!(/\A([-+])/, 1)
      sign ? sign.to_sym : :+
    end
    
    def trim_paddings!(str, pad_char)
      str.slice!(/\A#{pad_char}+/)
    end
    
    # @return [Integer]
    def parse_abs(str, chars)
      base = chars.length
      
      str.chars.reverse_each.with_index.inject(0) {|sum, char_index|
        char, index = *char_index
        
        if radix = chars.index(char.to_sym)
          sum + (radix * (base ** index))
        else
          raise InvalidCharacter
        end
      }
    end

  end

end; end