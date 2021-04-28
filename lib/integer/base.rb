# coding: us-ascii
# frozen_string_literal: true
# Copyright (C) 2011 Kenichi Kamiya

class Integer

  module Base

    class InvalidCharacterError < TypeError; end
    
    # @return [Regexp]
    SPECIAL_CHAR_PATTERN = /[\x00-\x20\-\+]/

    # @return [Hash]
    # @example
    #   { 1  => [:"0"],
    #     2  => [:"0", :"1"],
    #     36 => [:"0", :"1", ... , :Z] }
    STANDARD_CHARS = Hash.new{|*|raise KeyError}.tap {|standards|
      1.upto 10 do |n|
        standards[n] = (:'0'..((n - 1).to_s.to_sym)).to_a.freeze
      end
      
      alphabets = (:A..:Z).to_a
      
      11.upto 36 do |n|
        standards[n] = [
          *standards[10], *alphabets.slice(0, n - 10)
        ].freeze
      end
      
      standards[:BINARY] = standards[2]
    }.freeze

    # Crockford's Base32. Excluded I, L, O, U.
    # @see https://www.crockford.com/base32.html
    ENCODED_CROCKFORD_BASE32_CHARS = '0123456789ABCDEFGHJKMNPQRSTVWXYZ'.chars.map(&:to_sym).freeze

  end

end

require_relative 'base/refinementable'
require_relative 'base/singleton_class'
require_relative 'base/version'
