
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

map_layer: injured_bodypart {
  file: "body7.topojson"
  property_key: "bodypart"
}


week_start_day: monday

explore: safety_union {
  label: "Safety Incidents"
  view_label: "Incidents and Near Misses"
  join: asset_mapping_excel {
    view_label: "Asset/Function Filters"
    relationship: many_to_one
    sql_on: ${safety_union.asset_of_event} = ${asset_mapping_excel.safety};;
  }
  join: last_incident {
    relationship: one_to_one
    sql_on: ${last_incident.id} = ${safety_union.id} ;;
  }
  join: near_miss_hazard_type_last6months {
    relationship: many_to_one
    sql_on: ${safety_union.type_of_incident} = ${near_miss_hazard_type_last6months.hazard_type} ;;
  }
}

explore: nearmiss_word_count {

}
