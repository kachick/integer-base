class Integer; module Base
  
  # @example
  #   { 1  => [:"0"],
  #     2  => [:"0", :"1"],
  #     36 => [:"0", :"1", ... , :Z] }
  STANDARD_CHARS = Hash.new{|*|raise KeyError}.tap {|standards|
    1.upto 10 do |n|
      standards[n] = ('0'..((n - 1).to_s)).map(&:to_sym).freeze
    end
    
    alphabets = ('A'..'Z').map(&:to_sym)
    
    11.upto 36 do |n|
      standards[n] = [
        *standards[10], *alphabets.slice(0, n - 10)
      ].freeze
    end
    
    standards[:BINARY] = standards[2]
  }.freeze

end; end
