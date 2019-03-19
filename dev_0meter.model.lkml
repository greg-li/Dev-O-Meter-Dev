#test line

connection: "edm"

# include all the views
include: "*.view"

include: "*.dashboard.lookml"
#include: "*.dashboard"



# explore: deviation_goal  {
# }

explore: fact_deviations {
  label: "Deviations"
  view_label: " Deviations"
 always_filter: {
   filters: {
    field: dim_deviation_type.deviation_type
    value: "Customer Complaint - Packaging and shipping complaints"
    }
 }

#access_filter: {
#  field: dim_site.site_name
#  user_attribute:site
#}

  join: dim_site {
    view_label: "Site"
    sql_on: ${fact_deviations.site_key} =${dim_site.site_key}
    ;;relationship: many_to_one
  }
#   join:  dim_customers {
#     sql_on: ${fact_deviations.customer_key} = ${dim_customers.customer_key} ;;relationship: many_to_one
#   }
  join: bridge_customers_dev {
    sql_on: ${fact_deviations.parent_record_id} = ${bridge_customers_dev.parent_record_id};;
    relationship: many_to_one
    fields: []
  }
  join:  dim_customers {
    view_label: "Customers"
    sql_on: ${bridge_customers_dev.customer_key} = ${dim_customers.customer_key} ;;
    relationship: many_to_one
  }
  join:  dim_deviation_status {
    view_label: " Deviations"
    sql_on: ${fact_deviations.dev_status_key} = ${dim_deviation_status.dev_status_key} ;;
    relationship: many_to_one
  }
  join: dim_deviation_type {
    view_label: " Deviations"
    sql_on: ${fact_deviations.deviation_key} = ${dim_deviation_type.deviation_key} ;;
    relationship: many_to_one
  }
  join: dim_document {
    view_label: "Document"
    sql_on: ${fact_deviations.document_key} = ${dim_document.document_key} ;;
    relationship: many_to_one
    fields: []
  }
  join: dim_lot_batch {
    view_label: "Lot Batch"
    sql_on: ${fact_deviations.lot_key} = ${dim_lot_batch.lot_key} ;;
    relationship: many_to_one
  }
  join: dim_person {
    view_label: "Employees" ## can we just have this in the fact table
    sql_on: ${fact_deviations.initiating_person_key} =${dim_person.person_key} ;;
    relationship: many_to_one
  }
 join: assigned_person {
  view_label: "Employees" ##can we just have this in the fact table
  from: dim_person
  sql_on: ${fact_deviations.assigned_person_key} = ${dim_person.person_key} ;;
  relationship: many_to_one
}
  join:  dim_risk_category {
    view_label: "Risk Category"
    sql_on: ${fact_deviations.risk_cat_key} = ${dim_risk_category.risk_cat_key} ;;relationship: many_to_one
  }
  join: dim_root_cause {
    view_label: "Causes"
    sql_on: ${fact_deviations.root_cause_key} = ${dim_root_cause.root_cause_key} ;;relationship: many_to_one
  }
  join: dim_area {
    view_label: "Area"
    sql_on: ${fact_deviations.area_assigned_key} = ${dim_area.area_key} ;;relationship: many_to_one
  }
  join: area_occured {
    view_label: "Area"
    from:  dim_area
    sql_on: ${fact_deviations.area_occured_key} = ${area_occured.area_key} ;;relationship: many_to_one
}
  join: dim_causal {
    view_label: "Causes"
    sql_on: ${fact_deviations.causal_key} = ${dim_causal.causal_key} ;;relationship: many_to_one
  }
  join: dim_event_classification {
    view_label: "Events"
    sql_on: ${fact_deviations.event_class_key} = ${dim_event_classification.event_class_key} ;;relationship: many_to_one
  }
  join: alert_limit_check {
    sql_on: ${fact_deviations.event_class_key} = ${alert_limit_check.event_class_key}
    and ${fact_deviations.date_created_month}=${alert_limit_check.month_date_month};;
    relationship: many_to_one
  }

  join: deviations_by_event_classifications {
    view_label: "Events"
  sql_on: ${fact_deviations.event_class_key} = ${deviations_by_event_classifications.event_class_key}  ;;relationship: many_to_one
  }
  join: dim_bus_sec {
    view_label: "Business Sector"
    sql_on: ${fact_deviations.bus_sec_key} = ${dim_bus_sec.bus_sec_key}  ;;relationship: many_to_one
  }
  join: vw_asset_to_area {
    view_label: "Asset/Area"
    sql_on: ${fact_deviations.area_occured_key} = ${vw_asset_to_area.area_key} ;;relationship: many_to_one
  }
  join:lkp_shift {
    sql_on: ${fact_deviations.date_created_date} = ${lkp_shift.schedule_date} ;;relationship: many_to_one
    fields: []
  }

  join: dim_technology_business {
    view_label: "Technology Business"
    sql_on: ${fact_deviations.technology_business_key} = ${dim_technology_business.technology_business_key} ;;relationship: many_to_one
  }
  # join: dashboard_headers {
  #   sql_on: 1=1;;
  #   relationship: many_to_many
  # }
}

##Suggest Explores
explore: available_timezones {
 hidden: yes
}
#explore: assigned_person {}

#explore: area_occured {}
#explore: dim_area {}

#explore: dim_causal {}

#explore: dim_customers {}

#explore: dim_deviation_status {}

#explore: dim_deviation_type {}

#explore: dim_document {}

#explore: dim_lot_batch {}

#explore: dim_person {}

#explore: dim_risk_category {}

#explore: dim_root_cause {}

#explore: dim_site {}

#explore: dim_step {}
