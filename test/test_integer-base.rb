$VERBOSE = true
require_relative 'test_helper'

class TestIntegerBase < Test::Unit::TestCase
  MY_CHARS = ['0', *'A'..'I'].map(&:freeze).freeze
  
  def test_parse
    assert_equal(10, 'a0'.to_i(MY_CHARS))
    assert_equal(192, 'aib'.to_i(MY_CHARS))
  end
  
  def test_characterable
    assert_raises Integer::Base::InvalidCharacter do
      '210'.to_i('1'..'2')
    end
    
    assert_equal(21, '210'.to_i('0'..'2'))
  end
  
  def test_to_s
    assert_equal('aib', 192.to_s(MY_CHARS))
    chars_binary = %w[0 1]
    assert_equal('0', 0.to_s(chars_binary))
    assert_equal('1', 1.to_s(chars_binary))
    assert_equal('10', 2.to_s(chars_binary))
    assert_equal('11', 3.to_s(chars_binary))
    assert_equal('100', 4.to_s(chars_binary))
    assert_equal('101', 5.to_s(chars_binary))
  end
end
