#!/usr/bin/ruby -w

require_relative 'lib/integer/base'

p '019'.to_i
p(Integer::Base.parse '-019', ('0'..'9').to_a)
p(Integer::Base.parse '-019', ('0'..'9').to_a)
p Kernel.Integer('19')

require_relative 'lib/integer/base/import'

p '019'.to_i
p(Integer::Base.parse '-019', ('0'..'9').to_a)
p(Integer::Base.parse '-019', ('0'..'9').to_a)
p Kernel.Integer('19')

my_base_chars = %w[0 a]

p 'a'.to_i(my_base_chars)
p 'a0'.to_i(my_base_chars)