#test line

connection: "edm"

# include all the views
include: "*.view"

include: "*.dashboard.lookml"
#include: "*.dashboard"

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
explore: deviation_goal {}




explore: fact_deviations {
  label: "Deviations"
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

    sql_on: ${fact_deviations.site_key} =${dim_site.site_key}
    ;;relationship: many_to_one
  }
#   join:  dim_customers {
#     sql_on: ${fact_deviations.customer_key} = ${dim_customers.customer_key} ;;relationship: many_to_one
#   }
  join: bridge_customers_dev {
    sql_on: ${fact_deviations.parent_record_id} = ${bridge_customers_dev.parent_record_id};;
    type: inner
    relationship: many_to_one
  }
  join:  dim_customers {
    sql_on: ${bridge_customers_dev.customer_key} = ${dim_customers.customer_key} ;;
    type: inner
    relationship: many_to_one
  }
  join:  dim_deviation_status {
    sql_on: ${fact_deviations.dev_status_key} = ${dim_deviation_status.dev_status_key} ;;relationship: many_to_one
  }
  join: dim_deviation_type {
    sql_on: ${fact_deviations.deviation_key} = ${dim_deviation_type.deviation_key} ;;relationship: many_to_one
  }
  join: dim_document {
    sql_on: ${fact_deviations.document_key} = ${dim_document.document_key} ;;relationship: many_to_one
  }
  join: dim_lot_batch {
    sql_on: ${fact_deviations.lot_key} = ${dim_lot_batch.lot_key} ;;relationship: many_to_one
  }
  join: dim_person {
    sql_on: ${fact_deviations.initiating_person_key} =${dim_person.person_key} ;;relationship: many_to_one
  }
 join: assigned_person {
  from: dim_person
  sql_on: ${fact_deviations.assigned_person_key} =  ;;relationship: many_to_one
}
  join:  dim_risk_category {
    sql_on: ${fact_deviations.risk_cat_key} = ${dim_risk_category.risk_cat_key} ;;relationship: many_to_one
  }
  join: dim_root_cause {
    sql_on: ${fact_deviations.root_cause_key} = ${dim_root_cause.root_cause_key} ;;relationship: many_to_one
  }
  join: dim_area {
    sql_on: ${fact_deviations.area_assigned_key} = ${dim_area.area_key} ;;relationship: many_to_one
  }
  join: area_occured {
    from:  dim_area
    sql_on: ${fact_deviations.area_occured_key} = ${area_occured.area_key} ;;relationship: many_to_one
}
  join: dim_causal {
    sql_on: ${fact_deviations.causal_key} = ${dim_causal.causal_key} ;;relationship: many_to_one
  }
  join: dim_event_classification {
    sql_on: ${fact_deviations.event_class_key} = ${dim_event_classification.event_class_key} ;;relationship: many_to_one
  }
  join: alert_limit_check {
    sql_on: ${fact_deviations.event_class_key} = ${alert_limit_check.event_class_key} and ${fact_deviations.date_created_month}=${alert_limit_check.Month_date_month};;relationship: many_to_one
  }

  join: deviations_by_event_classifications {
  sql_on: ${fact_deviations.event_class_key} = ${deviations_by_event_classifications.event_class_key}  ;;relationship: many_to_one
  }
  join: dim_bus_sec {
    sql_on: ${fact_deviations.bus_sec_key} = ${dim_bus_sec.bus_sec_key}  ;;relationship: many_to_one
  }
  join: vw_asset_to_area {
    sql_on: ${fact_deviations.area_occured_key} = ${vw_asset_to_area.area_key} ;;relationship: many_to_one
  }
  join:lkp_shift {
    sql_on: ${fact_deviations.date_created_date} = ${lkp_shift.schedule_date} ;;relationship: many_to_one
  }
  join: dim_technology_business {
    sql_on: ${fact_deviations.technology_business_key} = ${dim_technology_business.technology_business_key} ;;relationship: many_to_one
  }
}
explore: dashboard_headers {}


##Suggest Explores
explore: available_timezones {
  hidden: yes
}
