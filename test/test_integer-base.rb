$VERBOSE = true
require File.dirname(__FILE__) + '/test_helper.rb'

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
  end
end
