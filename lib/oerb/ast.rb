module Oerb
  module AST
    Node = Struct.new(:level, :text, :marker, :code, :children, :parent) do
      def to_a
        [ [level, text, marker, code], children.map(&:to_a) ]
      end

      def to_s
        "Node{level: #{level}, text: #{text.inspect}, marker: #{marker}, code: #{code}, children: #{children.to_s}}"
      end

      def inspect ; to_s ; end

      def pp
        child_pp = children.map(&:pp).join(",\n").lines.map{|l| "  #{l}"}.join
        unless child_pp.empty?
          child_pp = "\n#{child_pp}\n"
        end
        "Node{level: #{level}, text: #{text.inspect}, marker: #{marker}, code: #{code}, children: [#{child_pp}]}"
      end

    end
  end
end
