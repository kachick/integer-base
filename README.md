integer-base
=============

[![Build Status](https://secure.travis-ci.org/kachick/integer-base.png)](http://travis-ci.org/kachick/integer-base)

Description
-----------

Any formats can mean positional/unary numeral systems :)  
So base number conversion under your choise.

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
Integer::Base.parse '10', %w[0 1]                   #=> 2
Integer::Base.string_for 10, %w[0 1]                #=> '2'


require 'integer/base/core_ext'

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

* [Ruby 1.9.2 or later](http://travis-ci.org/#!/kachick/integer-base)

Install
-------

```bash
$ gem install integer-base
```

Link
----

* [code](https://github.com/kachick/integer-base)
* [API](http://kachick.github.com/integer-base/yard/frames.html)
* [issues](https://github.com/kachick/integer-base/issues)
* [CI](http://travis-ci.org/#!/kachick/integer-base)
* [gem](https://rubygems.org/gems/integer-base)

License
--------

The MIT X11 License  
Copyright (c) 2011 Kenichi Kamiya  
See MIT-LICENSE for further details.