
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
