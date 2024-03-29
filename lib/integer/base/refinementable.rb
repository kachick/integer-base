# coding: us-ascii
# frozen_string_literal: true

class Integer
  module Base
    module StringPrepender
      # @param [Fixnum] base Delegate to standard to_i
      # @return [Integer]
      def to_i(base=10)
        case base
        when Enumerable
          ::Integer::Base.parse(self, base)
        else
          super(base)
        end
      end
    end

    module IntegerPrepender
      # @param [Fixnum] base Delegate to standard to_s
      # @return [String]
      def to_s(base=10)
        case base
        when Enumerable
          ::Integer::Base.string_for(self, base)
        else
          super(base)
        end
      end
    end

    refine String do
      import_methods Integer::Base::StringPrepender
    end

    refine Integer do
      import_methods Integer::Base::IntegerPrepender
    end
  end
end
