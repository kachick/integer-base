$VERSION = true

require_relative 'lib/integer/base'

# Format into your chars
p(Integer::Base.parse '-019', ('0'..'9').to_a)
p(Integer::Base.parse '-019', ('0'..'9').to_a)
p Kernel.Integer('19')

# No taint here
p '019'.to_i

# Overrided to_i, to_s
require_relative 'lib/integer/base/import'

# But, normal-format isn't changed
p '019'.to_i

puts '-' * 78

# Basic use cases
my_chars_1 = %w[0 a]
p 'a'.to_i(my_chars_1)
p 'a0'.to_i(my_chars_1)

my_chars_2 = ['0', *'A'..'I']
p 'a'.to_i(my_chars_2)
p 'a0'.to_i(my_chars_2)
p 'aib'.to_i(my_chars_2)
p 192.to_s(my_chars_2)

my_chars_3 = %w[0 1]
p 0.to_s(my_chars_3)
p 1.to_s(my_chars_3)
p 2.to_s(my_chars_3)
p 3.to_s(my_chars_3)