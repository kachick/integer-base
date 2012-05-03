# Copyright (C) 2011  Kenichi Kamiya

class Integer
  module Base 
    class InvalidCharacter < TypeError; end

    SPECIAL_CHAR = /[\x00-\x20\-\+]/
  end
end

require_relative 'base/version'
require_relative 'base/eigen'
require_relative 'base/standard_chars'