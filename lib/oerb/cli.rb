require 'pp'
require 'optparse'

module Oerb
  class CLI
    def initialize( args )
      parse_options( args )
    end

    def parse_options( args )
      options = @options = {port: 8069}
      OptionParser.new do |opt|
        opt.banner << ' [input file]'
        opt.on('-u', '--username USERNAME', 'OpenERP username') do |u|
          options[:username] = u
        end
        opt.on('-p', '--password PASSWORD', 'OpenERP password') do |p|
          options[:password] = p
        end
        opt.on('-d', '--domain DOMAIN', 'OpenERP domain/host') do |h|
          options[:domain] = h
        end
        opt.on('-P', '--port PORT', 'OpenERP port') do |h|
          options[:port] = p
        end
        opt.on('-y', '--dry-run', 'Dry run, leave the database unchanged') do
          options[:dry_run] = true
        end
        opt.on('-h', '--help', 'Print this help message') do
          puts opt
        end
      end.parse!(args)
      @input_file = args.pop
    end

    def execute
      @ast = Oerb::Parser.new( File.open( @input_file ) ).parse
      puts @ast.pp
    end

  end
end
