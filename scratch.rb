require 'ooor'

module OpenERP
  def self.connect(url, db, user, pwd)
    Ooor.new(url: url, database: db, username: user, password: pwd)
  end
end

p ProductProduct.find(1)

(AccountAccount.find :all, domain: [['code', 'ilike', '79%']]).map(&:code)
