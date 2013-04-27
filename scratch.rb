

#<AccountFinancialReport:0x00000002adb630
 @associations=
  {"children_ids"=>[5, 6],
   "parent_id"=>false,
   "account_type_ids"=>[],
   "account_ids"=>[106],
   "account_report_id"=>false},
 @attributes=
  {"name"=>"Balance Sheet",
   "sequence"=>0,
   "style_overwrite"=>false,
   "sign"=>1,
   "display_detail"=>"detail_flat",
   "type"=>"sum",
   "id"=>4},
 @ir_model_data_id=nil,
 @loaded_associations={},
 @object_session={:user_id=>nil, :database=>nil, :password=>nil, :context=>{}},
 @persisted=true,
 @prefix_options={}>


#<IrActionsAct_window:0x000000026ed7f8
  @associations=
   {"groups_id"=>[],
    "view_id"=>[452, "Accounting Report"],
    "search_view_id"=>false,
    "view_ids"=>[]},
  @attributes=
   {"domain"=>false,
    "help"=>false,
    "view_type"=>"form",
    "res_model"=>"accounting.report",
    "auto_search"=>true,
    "auto_refresh"=>0,
    "filter"=>false,
    "src_model"=>false,
    "view_mode"=>"form",
    "limit"=>80,
    "context"=>"{'default_account_report_id': 4}",
    "target"=>"new",
    "usage"=>false,
    "multi"=>false,
    "type"=>"ir.actions.act_window",
    "id"=>277,
    "name"=>"Balance Sheet"},
  @ir_model_data_id=nil,
  @loaded_associations={},
  @object_session=
   {:user_id=>nil, :database=>nil, :password=>nil, :context=>{}},
  @persisted=true,
  @prefix_options={}>

#<IrUiMenu:0x0000000270b348
  @associations=
   {"groups_id"=>[], "parent_id"=>[173, "Accounting Reports"], "child_id"=>[]},
  @attributes=
   {"name"=>"Balance Sheet",
    "web_icon"=>false,
    "sequence"=>10,
    "web_icon_hover"=>false,
    "id"=>236,
    "icon"=>"STOCK_PRINT"},
  @ir_model_data_id=nil,
  @loaded_associations={},
  @object_session=
   {:user_id=>nil, :database=>nil, :password=>nil, :context=>{}},
  @persisted=true,
  @prefix_options={}>

#<IrValues:0x00000002d39c38
 @associations=
  {"model_id"=>false,
   "user_id"=>false,
   "company_id"=>false,
   "action_id"=>false},
 @attributes=
  {"name"=>"Menuitem",
   "key2"=>"tree_but_open",
   "value"=>"ir.actions.act_window,277",
   "key"=>"action",
   "model"=>"ir.ui.menu",
   "res_id"=>236,
   "id"=>199},
 @ir_model_data_id=nil,
 @loaded_associations={},
 @object_session={:user_id=>nil, :database=>nil, :password=>nil, :context=>{}},
 @persisted=true,
 @prefix_options={}>

def create_menu_item(name)
  parent_id = IrModelData.find(:all, domain: [[ 'name', '=', 'final_accounting_reports' ]]).first
  $menu = IrUiMenu.new(
    "name"           =>name,
    "web_icon"       =>false,
    "sequence"       =>10,
    "web_icon_hover" =>false,
    "icon"           =>"STOCK_PRINT",
    "parent_id"      => parent_id.res_id
  )
end

IrModelData final_accounting_reports
=> [#<IrModelData:0x00000004636380 @attributes={"noupdate"=>false, "name"=>"final_accounting_reports", "date_init"=>Fri, 17 Aug 2012 15:12:36 +0000, "date_update"=>Fri, 17 Aug 2012 15:12:42 +0000, "module"=>"account", "model"=>"ir.ui.menu", "res_id"=>173, "id"=>3967}, @prefix_options={}, @ir_model_data_id=nil, @object_session={:user_id=>nil, :database=>nil, :password=>nil, :context=>{}}, @persisted=true, @associations={}, @loaded_associations={}>]
