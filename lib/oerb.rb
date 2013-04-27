require 'ooor'

module Oerb
  VERSION = '0.0.0'

  def self.connect(url, db, user, pwd)
    Ooor.new(url: url, database: db, username: user, password: pwd)
  end
end

require_relative './oerb/ooor_helpers'
require_relative './oerb/baker'
require_relative './oerb/ast'
require_relative './oerb/parser'
require_relative './oerb/cli'
