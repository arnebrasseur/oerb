require 'pp'
require 'optparse'

module Oerb
  class CLI
    attr_reader :options

    def initialize( args )
      parse_options( args )
    end

    def parse_options( args )
      options = @options = {port: 8069}
      optparse = OptionParser.new do |opt|
        opt.banner << ' [input files]'
        opt.on('-u', '--username USERNAME', 'OpenERP username')            {|u| options[:username] = u }
        opt.on('-p', '--password PASSWORD', 'OpenERP password')            {|p| options[:password] = p }
        opt.on('-d', '--database DATABASE', 'OpenERP database')            {|d| options[:database] = d }
        opt.on('-o', '--host HOST', 'OpenERP host')                        {|o| options[:host]     = o }
        opt.on('-P', '--port PORT', 'OpenERP port')                        {|h| options[:port]     = p }
        opt.on('-h', '--help', 'Print this help message')                  { puts opt; exit }
      end
      optparse.parse!(args)
      @input_files = args
      unless @input_files && @input_files.any?
        puts optparse
        puts
        STDERR.puts "WARNING : No input file specified!"
        exit
      end
    end

    def url
      "http://#{options[:host]}:#{options[:port]}/xmlrpc"
    end

    def execute
      Oerb.connect( url, options[:database], options[:username], options[:password] )
      @input_files.each do |input_file|
        @ast = Oerb::Parser.new( File.open( input_file ) ).parse
        Baker.new( @ast ).bake
      end
    end

  end
end
