# Copyright (C) 2011  Kenichi Kamiya

class Integer

  # @author Kenichi Kamiya
  module Base
    VERSION = '0.0.2'.freeze
  
    class InvalidCharacter < TypeError; end
    
    SPECIAL_CHAR = /[\x00-\x20\-\+]/
    
    class << self
      # @param [String] str
      # @param [Array<String>] chars
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
        
        str.slice!(/\A0+/)

        r = str.chars.reverse_each.with_index.inject(0) do |sum, rest|
          char, index = *rest
          sum += (
            if radix = chars.index(char)
              radix * (base ** index)
            else
              raise InvalidCharacter
            end
          )
        end
        
        minus ? -r : r       
      end

      # @param [Integer] int
      # @param [Array<String>] chars
      # @return [String]
      def convert_to_string(int, chars)
        raise TypeError unless int.kind_of? Integer
        return '0' if int == 0

        chars = base_chars_for chars
        base = chars.length
  
        ''.tap do |s|
          n = int

          until (n, excess = n.divmod base; n == 0 && excess == 0)
            s << chars[excess]
          end
          
          s.reverse!
        end
      end
      
      private
      
      def base_chars_for(chars)
        chars = chars.map(&:downcase)

        case
        when chars.length < 2
          raise TypeError, 'use 2 and more characters'
        when (chars.first != '0') || chars[1..-1].include?('0')
          raise InvalidCharacter, 'keep 0 for first character'
        when chars.dup.uniq!
          raise InvalidCharacter, 'dupulicated characters'
        when chars.any?{|s|(! s.kind_of?(String)) || (s.length != 1)}
          raise InvalidCharacter, 'chars must be Array<Char> (Char: String & length 1)'
        when chars.any?{|c|SPECIAL_CHAR =~ c}
          raise InvalidCharacter, 'included Special Characters (-, +, space, control-char)'
        else
          chars
        end
      end
    end
  end

end