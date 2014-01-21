#
# Mark Bates: A Big Look at MiniTest http://www.confreaks.com/videos/2713-arrrrcamp2013-a-big-look-at-minitest
# minitest-rails howto starts 22 minutes in
#
require 'minitest/autorun'

# enable context blocks
class Minitest::Spec
  class << self
    alias :context :describe
  end
end

class Foo
  def add(x, y)
    x + y
  end
end

describe Foo do

  let(:something) { [ 1, 2, 3 ] }

  before do # before each test
    @foo = 1
  end

  after do # after each test
    @foo = nil
  end

  context '#add' do
    it 'adds two numbers' do
      Foo.new.add(1,2).must_equal 3
    end
  end

  context 'skips' do
    it 'this because no block'

    it 'this explicitly' do
      skip
    end

    it 'this explicitly' do
      skip 'and outputs a reason'
    end
  end

  context 'expectations' do
    it 'uses must and wont' do
      true.must_equal true
      true.wont_equal false
    end

    it 'handles exceptions' do
      # stabby lambda!
      ->{nil/2}.must_raise NoMethodError
    end
  end

  # Minitest encourages you to build your own mocks with Struct/OpenStruct
  context 'mocking/stubbing' do
    let(:a_mock) { MiniTest::Mock.new }
    let(:some_thing) { Struct.new(:name).new('Widget') } # struct
    # let(:some_thing) { OpenStruct.new(name: 'Widget') } # OpenStruct

    it 'mocks' do
      a_mock.expect(:name, 'Widget') # expects call to name, returns widget
      a_mock.name.must_equal 'Widget'
      a_mock.verify # check whether it happened
    end

    it 'stubs with blocks' do
      some_thing.name.must_equal 'Widget'
      some_thing.stub(:name, 'Thingy') do
        # stub applies inside this block
        some_thing.name.must_equal 'Thingy'
      end
    end

    it 'try stubs in pure ruby!' do
      def some_thing.name # applies only to this instance
        'Whassit'
      end
      some_thing.name.must_equal 'Whassit'
    end
  end

  context 'custom assertions' do
    it 'can use them' do
      a = "Bob"
      b = "Jane"
      assert_clones(a,a)
      refute_clones(a,b)
      a.must_be_clones a
      a.wont_be_clones b
    end
  end
end

module MiniTest::Assertions
  def assert_clones a, b
    assert a == b
  end

  def refute_clones a, b
    refute a == b
  end
end
# infect specific types when assertion makes sense only for them
# NOTE: infection expects 2 args!
Object.infect_an_assertion :assert_clones, :must_be_clones
Object.infect_an_assertion :refute_clones, :wont_be_clones
