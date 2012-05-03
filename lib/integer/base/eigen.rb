# Copyright (C) 2011  Kenichi Kamiya

class Integer; module Base
  
  class << self

    # @param [String] str
    # @param [Array<#to_sym>] chars
    # @return [Integer]
    def parse(str, chars)
      chars = base_chars_for chars
      base = chars.length
      str = str.downcase
      
      if sign = str.slice!(/\A([-+])/, 1)
        if sign == '-'
          minus = true
        end
      end
      
      str.slice!(/\A#{chars.first}+/)

      r = str.chars.reverse_each.with_index.inject(0) {|sum, rest|
        char, index = *rest
        sum += (
          if radix = chars.index(char.to_sym)
            radix * (base ** index)
          else
            raise InvalidCharacter
          end
        )
      }
      
      minus ? -r : r       
    end

    # @param [Integer] int
    # @param [Array<#to_sym>] chars
    # @return [String]
    def convert_to_string(int, chars)
      raise TypeError unless int.kind_of? Integer
      chars = base_chars_for chars
      base = chars.length
      
      return chars.first.to_s if int == 0

      ''.tap {|s|
        n = int

        until (n, excess = n.divmod base; n == 0 && excess == 0)
          s << chars[excess].to_s
        end
        
        s.reverse!
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

  end

end; end