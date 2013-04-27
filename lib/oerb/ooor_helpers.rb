require 'ooor'


module Oerb
  module OoorHelpers
    def find_id_by_model_data_key( key )
      IrModelData.find(:all, domain: [[ 'name', '=', key ]]).first.res_id
    end

    def account_reports_menu_id
      parent_id = find_id_by_model_data_key 'final_accounting_reports'
    end
  end
end
