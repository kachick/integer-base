class Integer; module Base
  
  class << self

    # @param [String, #to_str] str
    # @param [Array<Symbol, String, #to_sym>] positional_chars
    # @return [Integer]
    def integer_for_string(str, positional_chars)
      str = str.to_str.downcase

      sign = parse_sign! str
      abs = (
        case positional_chars.length
        when 1
          parse_unary_abs str, positional_chars.first
        else
          parse_positional_abs str, positional_chars
        end
      )
      
      (sign == :-) ? -abs : abs
    end

    alias_method :parse, :integer_for_string

    # @param [Integer, #to_int] num
    # @param [Array<Symbol, String, #to_sym>] positional_chars
    # @return [String]
    def string_for_integer(num, positional_chars)
      case positional_chars.length
      when 1
        string_unary_for num, positional_chars.first
      else
        string_positional_for num, positional_chars
      end
    end

    alias_method :string_for, :string_for_integer

    private

    # @return [Symbol]
    def parse_sign!(str)
      sign = str.slice!(/\A([-+])/, 1)

      if sign
        if str.empty?
          raise InvalidCharacterError
        else
          sign.to_sym
        end
      else
        :+
      end
    end

    # @param [Array<#to_sym>] chars
    # @return [Array<Symbol>]
    def base_chars_for(chars)
      chars = chars.map{|c|c.downcase.to_sym}

      case
      when chars.length < 2
        raise TypeError, 'use 2 or more than characters'
      when chars.dup.uniq!
        raise InvalidCharacterError, 'dupulicated characters'
      when chars.any?{|s|s.length != 1}
        raise InvalidCharacterError,
        'chars must be Array<Char> (Char: length 1)'
      when chars.any?{|c|SPECIAL_CHAR_PATTERN =~ c}
        raise InvalidCharacterError,
        'included Special Characters (-, +, space, control-char)'
      else
        chars
      end
    end

    # @return [Symbol]
    def unary_char_for(char)
      unless (char.length == 1) and char.respond_to?(:to_sym)
        raise InvalidCharacterError, char
      end
      
      char.to_sym
    end
    
    def trim_positional_paddings!(str, pad_char)
      str.slice!(/\A#{Regexp.escape pad_char}+/)
    end
    
    # @return [Integer]
    def parse_positional_abs(str, chars)
      raise InvalidCharacterError if str.empty?
      base = chars.length
      chars = base_chars_for chars
      
      str = str.dup
      trim_positional_paddings! str, chars.first
      
      str.chars.reverse_each.with_index.inject(0) {|sum, char_index|
        char, index = *char_index
        
        if radix = chars.index(char.to_sym)
          sum + (radix * (base ** index))
        else
          raise InvalidCharacterError
        end
      }
    end
    
    # @return [Integer]
    def parse_unary_abs(str, char)
      char = unary_char_for char
      return 0 if str.empty?
      
      chars = str.chars.to_a

      atoms = chars.uniq      
      unless atoms.length == 1
        raise InvalidCharacterError, 'contain multiple chars' 
      end

      atom = atoms.first.to_sym
      unless atom == char
        raise InvalidCharacterError, 'not match the char and atom'
      end
      
      chars.length
    end
  
    # @return [String]
    def string_positional_for(num, chars)
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

    # @return [String]
    def string_unary_for(num, char)
      char = unary_char_for char
      int = num.to_int
      
      (char.to_s * int.abs).tap {|s|
        s.insert 0, '-' if int < 0
      }
    end

  end

end; end