# Copyright (C) 2011  Kenichi Kamiya

class String
  alias_method :original_to_i, :to_i
  
  remove_method :to_i

  # @overload to_i(base_number)
  #   @param [Fixnum] base_number Delegate to standard to_i
  # @overload to_i(positional_chars)
  #   @param [Array<#to_sym>] positional_chars
  # @return [Integer]
  def to_i(base=10)
    case base
    when Enumerable
      ::Integer::Base.parse self, base
    else
      original_to_i base
    end
  end
end

module Kernel
  alias_method :original_Integer, :Integer
  
  # @return [Integer]
  def Integer(obj)
    original_integer obj
  rescue ArgumentError
    if obj.kind_of? String
      ::Integer::Base.parse self, base
    else
      raise
    end
  end
end

class Integer

  # @overload to_s(base_number)
  #   @param [Fixnum] base_number Delegate to standard to_s
  # @overload to_s(positional_chars)
  #   @param [Array<#to_sym>] positional_chars
  # @return [String]
  def to_s(base=10)
    case base
    when Enumerable
      ::Integer::Base.convert_to_string self, base
    else
      original_to_s base
    end
  end
end

class Fixnum
  alias_method :original_to_s, :to_s
  remove_method :to_s
end

class Bignum
  alias_method :original_to_s, :to_s
  remove_method :to_s
end