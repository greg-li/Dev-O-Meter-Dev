#test line



#connection: "edm"

# include all the views
include: "*.view"

#include: "*.dashboard.lookml"

week_start_day: monday

explore: fact_deviations {
  label: "Deviations"
  view_label: " Deviations"
  always_filter: {
    #filters: {
    #  field: dim_deviation_type.deviation_type
    #  value: "Customer Complaint - Packaging and shipping complaints"
    #}
    filters: {
      field: fact_deviations.timezone_selection
      value: "Eastern Standard Time"
    }
  }

  join: dim_site {
    view_label: "Site"
    sql_on: ${fact_deviations.site_key} =${dim_site.site_key}
      ;;relationship: many_to_one
  }

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
    sql_on: ${fact_deviations.risk_cat_key} = ${dim_risk_category.risk_cat_key} ;;
    relationship: many_to_one
  }
  join: dim_root_cause {
    view_label: "Causes"
    sql_on: ${fact_deviations.root_cause_key} = ${dim_root_cause.root_cause_key} ;;
    relationship: many_to_one
  }
  join: dim_area {
    view_label: "Area"
    sql_on: ${fact_deviations.area_assigned_key} = ${dim_area.area_key} ;;
    relationship: many_to_one
  }
  join: area_occured {
    view_label: "Area"
    from:  dim_area
    sql_on: ${fact_deviations.area_occured_key} = ${area_occured.area_key} ;;
    relationship: many_to_one
  }
  join: dim_causal {
    view_label: "Causes"
    sql_on: ${fact_deviations.causal_key} = ${dim_causal.causal_key} ;;
    relationship: many_to_one
  }
  join: dim_event_classification {
    view_label: "Events"
    sql_on: ${fact_deviations.event_class_key} = ${dim_event_classification.event_class_key}
           and ${fact_deviations.date_created_year} = ${dim_event_classification.effective_year}
          and ${fact_deviations.bus_sec_key} = ${dim_event_classification.bus_sec_key}
          and ${fact_deviations.site_key} = ${dim_event_classification.site_key}
          ;;
    relationship: many_to_one
  }
  join: alert_limit_check {
    sql_on: ${fact_deviations.event_class_key} = ${alert_limit_check.event_class_key}
      and ${fact_deviations.date_created_month}=${alert_limit_check.month_date_month};;
    relationship: many_to_one
  }
  join: deviations_by_event_classifications {
    view_label: "Events"
    sql_on: ${fact_deviations.event_class_key} = ${deviations_by_event_classifications.event_class_key}  ;;
    relationship: many_to_one
  }
  join: dim_bus_sec {
    view_label: "Business Sector"
    sql_on: ${fact_deviations.bus_sec_key} = ${dim_bus_sec.bus_sec_key}  ;;
    relationship: many_to_one
  }
  join: vw_asset_to_area {
    view_label: "Asset/Area"
    sql_on: ${fact_deviations.area_occured_key} = ${vw_asset_to_area.area_key} ;;
    relationship: many_to_one
  }
  join: asset_mapping_excel {
    view_label: "Function / Asset Filter"
    relationship: many_to_one
    sql_on: ${vw_asset_to_area.asset}=${asset_mapping_excel.deviations};;
  }
  join:lkp_shift {
    sql_on: ${fact_deviations.date_created_date} = ${lkp_shift.schedule_date} ;;
    relationship: many_to_one
    fields: []
  }
  join: dim_technology_business {
    view_label: "Technology Business"
    sql_on: ${fact_deviations.technology_business_key} = ${dim_technology_business.technology_business_key} ;;
    relationship: many_to_one
  }
  join: event_classification_month_stats_dt {
    view_label: "Events"
    sql_on: ${dim_event_classification.event_class_key} = ${event_classification_month_stats_dt.event_class_key}
            and ${fact_deviations.date_created_month} = ${event_classification_month_stats_dt.date_created_month}
            and ${dim_site.site_name} = ${event_classification_month_stats_dt.site_name}
            and ${dim_bus_sec.bus_sec_name} = ${event_classification_month_stats_dt.bus_sec_name}
            ;;
    relationship: many_to_one
  }
  join: event_classification_year_stats_dt {
    view_label: "Events"
    sql_on: ${dim_event_classification.event_classification} = ${event_classification_year_stats_dt.event_classification}
      and ${fact_deviations.date_created_year} = ${event_classification_year_stats_dt.date_created_year}
      and ${dim_site.site_name} = ${event_classification_year_stats_dt.site_name}
      and ${dim_bus_sec.bus_sec_name} = ${event_classification_year_stats_dt.bus_sec_name}
            ;;
    relationship: many_to_one
  }
  join: event_classification_quarter_stats_dt {
    view_label: "Events"
    sql_on: ${dim_event_classification.event_class_key} =  ${event_classification_quarter_stats_dt.event_class_key}
      and ${fact_deviations.date_created_quarter} = ${event_classification_quarter_stats_dt.date_created_quarter}
      and ${dim_site.site_name} = ${event_classification_quarter_stats_dt.site_name}
      and ${dim_bus_sec.bus_sec_name} = ${event_classification_quarter_stats_dt.bus_sec_name}
            ;;
    relationship:many_to_one
  }
  join: deviations_target {
#     from: annual_fact_deviations
  type: full_outer
  relationship: many_to_one
  sql_on: ${fact_deviations.date_created_week} = ${deviations_target.daily_list_deviation_week}
        and ${fact_deviations.area_occured_key} = ${deviations_target.area_occured_key}
        and ${fact_deviations.site_key} = ${deviations_target.site_key};;
#   sql_where:
#       {% condition dim_site.site_name %} ${deviations_target.site_name} {% endcondition %}
#       AND {% condition asset_mapping_excel.master %} ${deviations_target.asset_mapping_excel_master} {% endcondition %}
#     ;;
}
join: all_deviation_customers_concat {
  type: left_outer
  view_label: "All Customers Concatenated"
  sql_on: ${fact_deviations.parent_record_id}=${all_deviation_customers_concat.parent_record_id} ;;
  relationship: one_to_one
}
}

##Suggest Explores
explore: available_timezones {
  hidden: yes
}



explore: deviations_target {
  always_filter: {
    #filters: {
    #  field: dim_deviation_type.deviation_type
    #  value: "Customer Complaint - Packaging and shipping complaints"
    #}
    filters: {
      field: fact_deviations.timezone_selection
      value: "Eastern Standard Time"
    }
  }
  always_join: [dim_deviation_status,dim_deviation_type]

  join: dim_site {
    type: left_outer
    view_label: "Site"
    sql_on: ${deviations_target.site_key} =${dim_site.site_key}
      ;;relationship: many_to_one
  }

  join: vw_asset_to_area {
    type: left_outer
    relationship: many_to_one
    sql_on: ${deviations_target.area_occured_key} = ${vw_asset_to_area.area_key} ;;
  }

  join: asset_mapping_excel {
    type: left_outer
    view_label: "Function / Asset Filter"
    relationship: many_to_one
    sql_on: ${vw_asset_to_area.asset}=${asset_mapping_excel.deviations} ;;
#     sql_where:
#     --{% condition dim_site.site_name %} ${deviations_target.site_name} {% endcondition %}
#     {% condition asset_mapping_excel.master %} ${deviations_target.asset_mapping_excel_master} {% endcondition %}
#    ;;
  }

  join: fact_deviations {
  type: left_outer
  relationship: one_to_many
  sql_on: ${deviations_target.daily_list_deviation_date} = ${fact_deviations.date_created_date}
          and ${deviations_target.site_key} = ${fact_deviations.site_key}
          and ${deviations_target.area_occured_key} = ${fact_deviations.area_occured_key};;

  }

  join:  dim_deviation_status {
    type: left_outer
    view_label: " Deviations"
    sql_on: ${fact_deviations.dev_status_key} = ${dim_deviation_status.dev_status_key} ;;
    sql_where: (${dim_deviation_status.deviation_status} not in ('Closed - Aborted', 'Closed - Cancelled', 'Closed - Voided') OR dim_deviation_status.DEVIATION_STATUS IS NULL);;
    relationship: many_to_one
  }

  join:  dim_risk_category {
    type: left_outer
    view_label: "Risk Category"
    sql_on: ${fact_deviations.risk_cat_key} = ${dim_risk_category.risk_cat_key} ;;
    relationship: many_to_one
  }

  join: dim_deviation_type {
    type: left_outer
    relationship: many_to_one
    view_label: " Deviations"
    sql_on: ${fact_deviations.deviation_key} = ${dim_deviation_type.deviation_key};;
    sql_where: (${dim_deviation_type.deviation_type} in ('Unplanned', 'Customer Complaint - Packaging and shipping complaints', 'Customer Complaint - Product quality complaints') or ${dim_deviation_type.deviation_type} is null);;
  }

}
