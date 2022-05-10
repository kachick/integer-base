integer-base
=============

![Build Status](https://github.com/kachick/integer-base/actions/workflows/test.yml/badge.svg?branch=main)
[![Gem Version](https://badge.fury.io/rb/integer-base.png)](http://badge.fury.io/rb/integer-base)

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

### Let's begin, your strange base number.

```ruby

':)'.to_i %w[) :]                                   #=> 2
```

Requirements
-------------

* Ruby 2.7 or later

Install
-------

```bash
$ gem install integer-base
```

Link
----

* [API documentation](https://kachick.github.io/integer-base/)

License
--------

The MIT X11 License  
Copyright (c) 2011 Kenichi Kamiya  
See MIT-LICENSE for further details.
