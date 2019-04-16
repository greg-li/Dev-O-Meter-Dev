# This view aggregates category (aka event classification) deviation count to the month,
# puts it next to that category's month alert limit,
# and creates a percentage to how close that limit is to being reached.

explore: event_classification_month_stats_dt {hidden:yes}
view: event_classification_month_stats_dt {
  derived_table: {
    explore_source: fact_deviations {
      column: event_class_key { field: dim_event_classification.event_class_key }
      column: date_created_month {field:fact_deviations.date_created_month}
      column: count {field: fact_deviations.count}
      column: alert_limit { field: dim_event_classification.alert_limit }
      column: event_classification {field:dim_event_classification.event_classification}
      column: site_name {field: dim_site.site_name}
      column: bus_sec_name {field: dim_bus_sec.bus_sec_name}
      filters: {
        field: dim_deviation_type.deviation_type
        value: "Unplanned,Customer Complaint - Product quality complaints,Customer Complaint - Packaging and shipping complaints"
      }
#       filters: {
#         field: fact_deviations.timezone_selection
#         value: "Eastern Standard Time"
#       }
#       filters: {
#         field: dim_site.site_name
#         value: "Portsmouth"
#       }
      filters: {
        field: dim_deviation_status.deviation_status
        value: "-Closed - Aborted,-Closed - Cancelled,-Closed - Voided"
      }
#       filters: {
#         field: dim_bus_sec.bus_sec_name
#         value: "LPB Portsmouth MM"
#       }
    }
  }
  dimension: pk {
    hidden: yes
    primary_key: yes
    sql: concat(${event_class_key}, '-', ${date_created_month}, '-', ${site_name}, '-', ${bus_sec_name}) ;;
  }
  dimension: event_class_key {
    hidden: yes
  }
  dimension: date_created_month {
    type: date_month
    hidden: yes
  }

  dimension: event_classification {}

  dimension: date_created_quarter {
    hidden: yes
    type: date_quarter
    sql: ${TABLE}.date_created_month ;;
  }
  dimension: category_monthly_deviation_count {
    group_label: "Category Monthly Facts"
    description: "Count of total deviations for the Event Category during whatever month is under analysis"
    type: number
    sql: ${TABLE}.count ;;
  }
  dimension: alert_limit {
    type: number
    hidden: yes
  }
  dimension: percent_alert_limit_reached {
    group_label: "Category Monthly Facts"
    type: number
    sql: ${category_monthly_deviation_count}*100.0/NULLIF(${alert_limit},0) ;;
    value_format: "0\%"
  }
  dimension: alert_limit_exceeded {
    group_label: "Category Monthly Facts"
    type: yesno
    description: "Monthly limit to deviations hit or exceeded"
    sql: ${alert_limit}<${category_monthly_deviation_count} ;;
  }

  dimension: site_name {
    type: string
    sql: ${TABLE}.site_name ;;
  }

  dimension: bus_sec_name {
    type: string
    sql: ${TABLE}.bus_sec_name ;;
  }


  measure: count {
    type:count
    hidden:yes
  }
  measure: count_alert_limit_exceeded {
    group_label: "Category Monthly Facts"
    description: "Count of Months where limit to deviations hit or exceeded"
    type: count
    filters: {
      field: alert_limit_exceeded
      value: "Yes"
    }
    drill_fields: [fact_deviations.date_created_month, dim_event_classification.event_classification, alert_limit, percent_alert_limit_reached, fact_deviations.count]
  }
}
