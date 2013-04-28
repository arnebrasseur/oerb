module Oerb
  class Baker
    include OoorHelpers

    def initialize( ast )
      @root = ast
    end

    def bake
      report_id = bake_sum_node false, @root, 0
      create_menu_item @root.text, report_id
    end

    private

    def bake_node( parent_id, node, sequence )
      if node.children.empty?
        bake_leaf_node( parent_id, node, sequence )
      else
        bake_sum_node( parent_id, node, sequence )
      end
    end

    def sign( marker )
      marker =~ /-/ ? -1 : 1
    end

    def bake_leaf_node( parent_id, node, sequence )
      if node.code.nil?
        raise "Leaf node without code specification : #{node.inspect}"
      end
      account_ids = find_accounts( node.code )
      sign = node.marker =~ /-/ ? -1 : 1
      create_financial_report_row(node.text, sequence, parent_id, account_ids, :accounts, sign(node.marker))
    end

    def bake_sum_node( parent_id, node, sequence )
      parent_id = create_financial_report_row(node.text, sequence, parent_id, [], :sum, sign(node.marker))
      node.children.each.with_index do |child_node, idx|
        bake_node( parent_id, child_node, idx )
      end
      parent_id
    end

    def create_financial_report_row(name, sequence, parent_id, account_ids, type, sign)
      report = AccountFinancialReport.new(
        "name"            => name,
        "sequence"        => sequence,
        "style_overwrite" => false,
        "sign"            => sign,
        "display_detail"  => "detail_flat",
        "type"            => type.to_s,
        "account_ids"     => account_ids,
        "parent_id"       => parent_id
      )
      report.save
      report.id
    end

    def create_menu_item(name, report_id)
      action = IrActionsAct_window.new(
        "view_id"      => find_id_by_model_data_key( 'accounting_report_view' ),
        "domain"       => false,
        "help"         => false,
        "view_type"    => "form",
        "res_model"    => "accounting.report",
        "auto_search"  => true,
        "auto_refresh" => 0,
        "filter"       => false,
        "src_model"    => false,
        "view_mode"    => "form",
        "limit"        => 80,
        "context"      => "{'default_account_report_id': #{report_id}}",
        "target"       => "new",
        "usage"        => false,
        "multi"        => false,
        "type"         => "ir.actions.act_window",
        "name"         => name
      )
      action.save
      menu = IrUiMenu.new(
        "name"           => name,
        "web_icon"       => false,
        "sequence"       => 10,
        "web_icon_hover" => false,
        "icon"           => "STOCK_PRINT",
        "parent_id"      => account_reports_menu_id,
        "action"         => "ir.actions.act_window,#{action.id}"
      )
      menu.save
    end
  end
end
