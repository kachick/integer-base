integer-base
=============

![Build Status](https://github.com/kachick/integer-base/actions/workflows/test_behaviors.yml/badge.svg?branch=main)
[![Gem Version](https://badge.fury.io/rb/integer-base.svg)](http://badge.fury.io/rb/integer-base)

Description
-----------

Any formats can mean positional/unary numeral systems :)
So base number conversion under your choice.

Features
--------

* You can easily build base numbers.
* An example, upper the "36".

Usage
-----

### Introduction

```ruby
require 'integer/base'

Integer::Base.parse '10', %w[0 1 2 3 4 5 6 7 8 9]   #=> 10

# Extend core methods with refinement
using Integer::Base

'10'.to_i %w[0 1]                                   #=> 2
10.to_s   %w[0 1]                                   #=> "2"
```

### Upper 36 base number

```ruby
'10'.to_i 36                                        #=> 36
'10'.to_i [*'0'..'9', *'A'..'Z']                    #=> 36
'10'.to_i 37                                        #=> ArgumentError
'10'.to_i [*'0'..'9', *'A'..'Z', '?']               #=> 37
'1?'.to_i [*'0'..'9', *'A'..'Z', '?']               #=> 73 (37 * 1 + 36 * 1)
```

### Actual usecase, special mapping as [Crockford's base32](https://www.crockford.com/base32.html)

```ruby
1998335352370349147064579878655797352.to_s('0123456789ABCDEFGHJKMNPQRSTVWXYZ'.chars)
# => "1g3erma7w2dm6934zqz3qda38"
```

### Let's begin, your strange base number.

```ruby

':)'.to_i %w[) :]                                   #=> 2
```

Link
----

* [Repository](https://github.com/kachick/integer-base)
* [API documentation](https://kachick.github.io/integer-base/)

License
--------

The MIT X11 License
Copyright (c) 2011 Kenichi Kamiya

