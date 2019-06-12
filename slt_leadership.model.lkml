
include: "*.view.lkml"                       # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
# explore: order_items {
#   join: orders {
#     relationship: many_to_one
#     sql_on: ${orders.id} = ${order_items.order_id} ;;
#   }
#
#   join: users {
#     relationship: many_to_one
#     sql_on: ${users.id} = ${orders.user_id} ;;
#   }
# }

week_start_day: monday

explore: combined_metrics {
  join: asset_mapping_excel {
    relationship: many_to_one
    sql_on: ${combined_metrics.asset_function} = ${asset_mapping_excel.excel} ;;
  }
}

explore: msat_weekly_data {
  join: asset_mapping_excel {
    relationship: many_to_one
    sql_on: ${msat_weekly_data.asset_function}=${asset_mapping_excel.excel} ;;
  }
}

explore: engineering_facilities {
  label: "Engineering & Facilities"
  view_label: "Work Order Data"
  join: asset_mapping_excel {
    view_label: "Asset/Function Filters"
    relationship: many_to_one
    sql_on: ${engineering_facilities.Function_Mapping} = ${asset_mapping_excel.excel};;
  }
}

explore: sltweekly_data_entry_excel_ppl {
  label: "PPL Manufacturing"
  view_label: "SLT Weekly PPL"
  join: asset_mapping_excel {
    relationship: many_to_one
    sql_on: ${sltweekly_data_entry_excel_ppl.asset_function} = ${asset_mapping_excel.excel};;
  }
}

explore: looker_sltdashlinks {
  join: asset_mapping_excel {
    relationship: one_to_one
    sql_on:  ${asset_mapping_excel.master}=${looker_sltdashlinks.asset_function} ;;
  }
}

explore: sltweekly_data_entry_excel_qc {
  label: "QC Weekly Data"
  join: asset_mapping_excel {
    relationship: many_to_one
    sql_on: ${sltweekly_data_entry_excel_qc.asset_function}=${asset_mapping_excel.excel} ;;
  }
}

explore: pmop_open_by_week {
  label: "PMOP Open Order Counts"
}

explore: bdops_open_by_week {
  label: "BDOP Open Order Counts"
}

explore: qc_testing_union {
  label: "QC Testing Data"
  join: asset_mapping_excel {
    relationship: many_to_one
    sql_on: ${qc_testing_union.asset_function}=${asset_mapping_excel.excel} ;;
  }
}

explore: workday_counts {
  label: "Workday Data"
  join: asset_mapping_excel {
    relationship: many_to_one
    sql_on: ${workday_counts.asset_mapping} = ${asset_mapping_excel.master} ;;
  }
}
