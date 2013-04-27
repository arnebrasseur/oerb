module Oerb
  class Parser
    CODE_REGEXP = %r{([!?]-?) ((\d+,)*\d+(\/\d+)?)}
    def initialize( input )
      @input = input
      @root  = nil
      @last_node = nil
    end

    def parse_line( line )
      level = line[/\A\s*/].length / 2
      if line =~ CODE_REGEXP
        marker, code = $1, $2
      end
      text = line.gsub(CODE_REGEXP, '').strip
      [level, text, marker, parse_code(code)]
    end

    def parse_code( code )
      case code
      when /\A\d+\z/
        Integer(code)
      when /\A(\d+)\/(\d+)\z/
        Integer($1)..Integer($2)
      when /\A(\d+,)+\d+/
        code.split(',').map(&:to_i)
      end
    end

    def process_node( node )
      if @root.nil?
        @root = @last_node = node
      else
        case node.level <=> @last_node.level
        when 0
          node.parent = @last_node.parent
        when 1
          node.parent = @last_node
        when -1
          node.parent = @last_node.parent
          node.parent = node.parent.parent until node.level == node.parent.level + 1
        end
        node.parent.children << node
      end
      @last_node = node
    end

    def parse
      @input.each_line do |line|
        next if line =~ /\A\s*\z/
        next if line =~ /\A#/
        self.process_node(
          Oerb::AST::Node.new( *parse_line(line), [], nil )
        )
      end
      @root
    end
  end
end

__END__

require 'minitest/autorun'

describe Oerb::Parser do
  before do
    @parser = Oerb::Parser.new('')
  end

  describe 'code regexp' do
    it 'must catch the marker !' do
      '! 50' =~ Oerb::Parser::CODE_REGEXP
      $1.must_equal('!')
    end

    it 'must catch the marker ?' do
      '? 50' =~ Oerb::Parser::CODE_REGEXP
      $1.must_equal('?')
    end

    it 'must catch the marker !-' do
      '!- 50' =~ Oerb::Parser::CODE_REGEXP
      $1.must_equal('!-')
    end

    it 'must catch simple codes' do
      '! 50' =~ Oerb::Parser::CODE_REGEXP
      $2.must_equal '50'
    end

    it 'must catch range codes' do
      '! 50/60' =~ Oerb::Parser::CODE_REGEXP
      $2.must_equal '50/60'
    end

  end

  it 'should parse individual lines' do
    level, text, marker, code = @parser.parse_line('      VIII. Geldbeleggingen (toel. II) ! 50/53')
    level.must_equal 3
    marker.must_equal '!'
    code.must_equal 50..53
    text.must_equal 'VIII. Geldbeleggingen (toel. II)'
  end

  describe 'syntax tree' do
    before do
      @parser = Oerb::Parser.new(
%q{EIGEN VERMOGEN
  I. Kapitaal (toel.III)
    A.Geplaatst kapitaal ! 10,11
    B.Niet-opgevraagd kapitaal !- 101/105
  II. Uitgiftepremies ! 11})
    end

    it "should build a tree based on levels" do
      # [ node, [[node, [children]], [node, [children]]] ]

      @parser.parse.to_a.must_equal [
        [0, 'EIGEN VERMOGEN', nil, nil], [
                                           [ [1, 'I. Kapitaal (toel.III)', nil, nil], [
                                                                                        [ [2, 'A.Geplaatst kapitaal', '!', [10,11]],         [] ],
                                                                                        [ [2, 'B.Niet-opgevraagd kapitaal', '!-', 101..105], [] ]
                                                                                      ] ],
                                           [ [1, 'II. Uitgiftepremies', '!', 11 ], [] ]
                                         ] ]
    end
  end
end
# >> Run options: --seed 22591
# >>
# >> # Running tests:
# >>
# >> .......
# >>
# >> Finished tests in 0.000964s, 7258.8958 tests/s, 10369.8511 assertions/s.
# >>
# >> 7 tests, 10 assertions, 0 failures, 0 errors, 0 skips
