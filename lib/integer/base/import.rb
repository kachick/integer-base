# Copyright (C) 2011  Kenichi Kamiya

class String
  alias_method :original_to_i, :to_i
  
  remove_method :to_i

  # @param [Fixnum] base
  # @param [Array<String>] base
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
  alias_method :original_to_s, :to_s

  # @param [Fixnum] base
  # @param [Array<String>] base
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