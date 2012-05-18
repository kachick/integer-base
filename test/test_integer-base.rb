$VERBOSE = true
require_relative 'test_helper'

class TestIntegerBase < Test::Unit::TestCase
  def test_parse
    assert_equal(1, '0a'.to_i(['0', *'A'..'I']))
    
    assert_equal(0, ''.to_i(['0']))
    assert_equal(1, '0'.to_i(['0']))
    assert_equal(2, '00'.to_i(['0']))

    assert_raises Integer::Base::InvalidCharacter do
      '01'.to_i(['0'])
    end

    assert_raises Integer::Base::InvalidCharacter do
      '9a'.to_i(['0', *'A'..'I'])
    end
    
    assert_equal(1, '9a'.to_i(['9', *'A'..'I']))
    assert_equal(10, '9a9'.to_i(['9', *'A'..'I']))
    
    assert_raises Integer::Base::InvalidCharacter do
      '9a'.to_i(['9', *'A'..'I', 'B'])
    end
    
    assert_equal(1, Integer::Base.parse('00a', ['0', *'A'..'I']))
    
    assert_equal(1, '00a'.to_i(['0', *'A'..'I']))
    assert_equal(1, '99a'.to_i(['9', *'A'..'I']))

    assert_equal(10, 'a0'.to_i(['0', *'A'..'I']))
    assert_equal(192, 'aib'.to_i(['0', *'A'..'I']))
    assert_equal(10, '+a0'.to_i(['0', *'A'..'I']))
    assert_equal(192, '+aib'.to_i(['0', *'A'..'I']))
    assert_equal(-10, '-a0'.to_i(['0', *'A'..'I']))
    assert_equal(-192, '-aib'.to_i(['0', *'A'..'I']))
    
    assert_raises Integer::Base::InvalidCharacter do
      'a-ib'.to_i(['0', *'A'..'I'])
    end
    
    assert_raises Integer::Base::InvalidCharacter do
      'a+ib'.to_i(['0', *'A'..'I'])
    end

    assert_raises Integer::Base::InvalidCharacter do
      '~aib'.to_i(['0', *'A'..'I'])
    end
  end
  
  def test_characterable
    assert_raises Integer::Base::InvalidCharacter do
      '210'.to_i(('1'..'2').to_a)
    end
    
    assert_equal(21, '210'.to_i(('0'..'2').to_a))
  end
  
  def test_to_s
    assert_equal('aib', 192.to_s(['0', *'A'..'I']))
    assert_equal('0', 0.to_s(%w[0 1]))
    assert_equal('1', 1.to_s(%w[0 1]))
    assert_equal('10', 2.to_s(%w[0 1]))
    assert_equal('11', 3.to_s(%w[0 1]))
    assert_equal('100', 4.to_s(%w[0 1]))
    assert_equal('101', 5.to_s(%w[0 1]))
    
    assert_equal('-aib', -192.to_s(['0', *'A'..'I']))
    assert_equal('-1', -1.to_s(%w[0 1]))
    assert_equal('-10', -2.to_s(%w[0 1]))
    assert_equal('-11', -3.to_s(%w[0 1]))
    assert_equal('-100', -4.to_s(%w[0 1]))
    assert_equal('-101', -5.to_s(%w[0 1]))
    
    assert_equal('0' * 192, 192.to_s(['0']))
    assert_equal('', 0.to_s(['0']))
    assert_equal('0', 1.to_s(['0']))
    assert_equal('00', 2.to_s(['0']))
    assert_equal('000', 3.to_s(['0']))

    assert_equal("-#{'0' * 192}", -192.to_s(['0']))
    assert_equal('-0', -1.to_s(['0']))
    assert_equal('-00', -2.to_s(['0']))
    assert_equal('-000', -3.to_s(['0']))

  end
  
  def test_binary
    assert_equal 2, Integer::Base.parse('10', %w[0 1])
  end
  
  def test_standards_to_i
    assert_raises Integer::Base::InvalidCharacter do
      Integer::Base.parse('', Integer::Base::STANDARD_CHARS[2])
    end
    
    assert_equal(0, Integer::Base.parse('', Integer::Base::STANDARD_CHARS[1]))
    
    assert_raises Integer::Base::InvalidCharacter do
      Integer::Base.parse('-', Integer::Base::STANDARD_CHARS[2])
    end
    
    assert_raises Integer::Base::InvalidCharacter do
      Integer::Base.parse('-', Integer::Base::STANDARD_CHARS[1])
    end

    assert_raises Integer::Base::InvalidCharacter do
      Integer::Base.parse('+', Integer::Base::STANDARD_CHARS[2])
    end
    
    assert_raises Integer::Base::InvalidCharacter do
      Integer::Base.parse('+', Integer::Base::STANDARD_CHARS[1])
    end

    assert_equal(1, Integer::Base.parse('0', Integer::Base::STANDARD_CHARS[1]))
    assert_equal(2, Integer::Base.parse('00', Integer::Base::STANDARD_CHARS[1]))
    assert_equal('11'.to_i(2), Integer::Base.parse('11', Integer::Base::STANDARD_CHARS[2]))
    assert_equal('101'.to_i(2), Integer::Base.parse('101', Integer::Base::STANDARD_CHARS[2]))
    assert_equal('11'.to_i(27), Integer::Base.parse('11', Integer::Base::STANDARD_CHARS[27]))
    assert_equal('101'.to_i(27), Integer::Base.parse('101', Integer::Base::STANDARD_CHARS[27]))
    assert_equal('11'.to_i(36), Integer::Base.parse('11', Integer::Base::STANDARD_CHARS[36]))
    assert_equal('101'.to_i(36), Integer::Base.parse('101', Integer::Base::STANDARD_CHARS[36]))

    assert_raises KeyError do
      Integer::Base::STANDARD_CHARS[37]
    end
  end
  
  def test_implements
    assert_raises ArgumentError do
      '00'.to_i 1
    end
  end
  
  def test_upper36
    assert_equal(73, '1!'.to_i([*Integer::Base::STANDARD_CHARS[36], '!']))
  end
end
