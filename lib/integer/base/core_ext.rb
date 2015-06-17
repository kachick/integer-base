# coding: us-ascii

require_relative '../base'


class Integer; module Base
  
  module StringPrepender
    # @param [Fixnum] base_number Delegate to standard to_i
    # @param [Array<Symbol, String, #to_sym>] positional_chars
    # @return [Integer]
    def to_i(base=10)
      case base
      when Enumerable
        ::Integer::Base.parse self, base
      else
        super base
      end
    end
  end

  module IntegerPrepender
    # @param [Fixnum] base_number Delegate to standard to_s
    # @param [Array<Symbol, String, #to_sym>] positional_chars
    # @return [String]
    def to_s(base=10)
      case base
      when Enumerable
        ::Integer::Base.string_for self, base
      else
        super base
      end
    end
  end

end; end

class String
  prepend Integer::Base::StringPrepender
end

class Fixnum
  prepend Integer::Base::IntegerPrepender
end

class Bignum
  prepend Integer::Base::IntegerPrepender
end
