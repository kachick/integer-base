# Copyright (C) 2011  Kenichi Kamiya

class Integer; module Base
  
  class << self

    # @param [#to_str] str
    # @param [Array<#to_sym>] chars
    # @return [Integer]
    def parse(str, chars)
      str = str.to_str.downcase

      sign = parse_sign! str
      abs = (
        case chars.length
        when 1
          parse_unary_abs str, chars.first
        else
          parse_positional_abs str, chars
        end
      )
      
      (sign == :-) ? -abs : abs
    end

    # @param [#to_int] num
    # @param [Array<#to_sym>] chars
    # @return [String]
    def string_for(num, chars)
      case chars.length
      when 1
        convert_to_string_unary num, chars.first
      else
        convert_to_string_positional num, chars
      end
    end
    
    alias_method :convert_to_string, :string_for

    private

    # @return [Symbol]
    def parse_sign!(str)
      sign = str.slice!(/\A([-+])/, 1)

      if sign
        if str.empty?
          raise InvalidCharacter
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
        raise InvalidCharacter, 'dupulicated characters'
      when chars.any?{|s|s.length != 1}
        raise InvalidCharacter, 'chars must be Array<Char> (Char: length 1)'
      when chars.any?{|c|SPECIAL_CHAR_PATTERN =~ c}
        raise InvalidCharacter, 'included Special Characters (-, +, space, control-char)'
      else
        chars
      end
    end

    # @return [Symbol]
    def unary_char_for(char)
      raise InvalidCharacter unless (char.length == 1) and char.respond_to?(:to_sym)
      
      char.to_sym
    end
    
    def trim_positional_paddings!(str, pad_char)
      str.slice!(/\A#{pad_char}+/)
    end
    
    # @return [Integer]
    def parse_positional_abs(str, chars)
      raise InvalidCharacter if str.empty?
      base = chars.length
      chars = base_chars_for chars
      
      str = str.dup
      trim_positional_paddings! str, chars.first
      
      str.chars.reverse_each.with_index.inject(0) {|sum, char_index|
        char, index = *char_index
        
        if radix = chars.index(char.to_sym)
          sum + (radix * (base ** index))
        else
          raise InvalidCharacter
        end
      }
    end
    
    # @return [Integer]
    def parse_unary_abs(str, char)
      char = unary_char_for char
      return 0 if str.empty?
      
      chars = str.chars.to_a
      atoms = chars.uniq      
      raise InvalidCharacter, 'contain multiple chars' unless atoms.length == 1
      
      atom = atoms.first.to_sym
      raise InvalidCharacter, 'not match the char and atom' unless atom == char
      
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
    
    alias_method :convert_to_string_positional, :string_positional_for
  
    # @return [String]
    def string_unary_for(num, char)
      char = unary_char_for char
      int = num.to_int
      
      (char.to_s * int.abs).tap {|s|
        s.insert 0, '-' if int < 0
      }
    end
    
    alias_method :convert_to_string_unary, :string_unary_for

  end

end; end