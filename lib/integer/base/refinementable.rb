# coding: us-ascii
# frozen_string_literal: true

class Integer; module Base
  
  module StringPrepender
    # @param [Fixnum] base Delegate to standard to_i
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
    # @param [Fixnum] base Delegate to standard to_s
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

  refine String do
    # @TODO Remove this branch since dropped to support Ruby 3.0 or older
    if respond_to?(:import_methods, true)
      import_methods Integer::Base::StringPrepender
    else
      prepend Integer::Base::StringPrepender
    end
  end
  
  refine Integer do
    # @TODO Remove this branch since dropped to support Ruby 3.0 or older
    if respond_to?(:import_methods, true)
      import_methods Integer::Base::IntegerPrepender
    else
      prepend Integer::Base::IntegerPrepender
    end
  end

end; end
