require 'ooor'


module Oerb
  module OoorHelpers
    def find_id_by_model_data_key( key )
      IrModelData.find(:all, domain: [[ 'name', '=', key ]]).first.res_id
    end

    def account_reports_menu_id
      parent_id = find_id_by_model_data_key 'final_accounting_reports'
    end

    def find_accounts( code )
      case code
      when Range, Array
        code.to_a.flat_map{|c| find_accounts( c ) }
      else
        exact_match = AccountAccount.find(:all, :domain => ['code', '=', code.to_s])
        if exact_match && !exact_match.empty?
          exact_match.map(&:id)
        else
          AccountAccount.find(:all, :domain => ['code', 'like', "#{code}%"]).select do |account|
            account.child_id.empty? #only leaf accounts
          end.map(&:id)
        end
      end
    end

  end
end
