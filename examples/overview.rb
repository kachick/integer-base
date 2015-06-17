# coding: us-ascii

require_relative '../lib/integer/base'

Integer::Base.parse '10', %w[0 1 2 3 4 5 6 7 8 9]   #=> 10
Integer::Base.parse '10', %w[0 1]                   #=> 2
Integer::Base.string_for 10, %w[0 1]                #=> '2'

using Integer::Base

'10'.to_i %w[0 1]                                   #=> 2
10.to_s   %w[0 1]                                   #=> "2"

### Upper 36 base number

'10'.to_i 36                                        #=> 36
'10'.to_i [*'0'..'9', *'A'..'Z']                    #=> 36
# '10'.to_i 37                                        #=> ArgumentError
'10'.to_i [*'0'..'9', *'A'..'Z', '?']               #=> 37
'1?'.to_i [*'0'..'9', *'A'..'Z', '?']               #=> 73 (37 * 1 + 36 * 1)

### Let's begin, your strange base number.

':)'.to_i %w[) :]                 
