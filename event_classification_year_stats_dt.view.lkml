# If necessary, uncomment the line below to include explore_source.
# include: "dev_0meter.model.lkml"

view: event_classification_year_stats_dt {
  derived_table: {
    explore_source: fact_deviations {
      column: date_created_year {}
      column: event_classification { field: dim_event_classification.event_classification }
      column: action_limit { field: dim_event_classification.action_limit }
      column: count {}
      filters: {
        field: dim_deviation_type.deviation_type
        value: "Unplanned,Customer Complaint - Product quality complaints,Customer Complaint - Packaging and shipping complaints"
      }
      filters: {
        field: fact_deviations.timezone_selection
        value: "Eastern Standard Time"
      }
      filters: {
        field: alert_limit_check.timezone_selection
        value: "Eastern Standard Time"
      }
      filters: {
        field: dim_site.site_name
        value: "Portsmouth"
      }
      filters: {
        field: dim_deviation_status.deviation_status
        value: "-Closed - Aborted,-Closed - Cancelled,-Closed - Voided"
      }
      filters: {
        field: dim_bus_sec.bus_sec_name
        value: "LPB Portsmouth MM"
      }
    }
  }
  dimension: pk {
    hidden: yes
    primary_key: yes
    sql: concat(${event_classification}, '-', ${date_created_year}) ;;
  }
  dimension: date_created_year {
    hidden: yes
    label: " Deviations  Created Year"
    type: date_year
  }
  dimension: event_classification {
    hidden: yes
    label: "Event Category Name"
  }
  dimension: action_limit {
    hidden: yes
    label: "Event Action Limit"
    description: "Annual Deviation Limit"
    type: number
  }
  dimension: category_yearly_deviation_count {
    group_label: "Category Yearly Facts"
    type: number
    sql: ${TABLE}.count ;;
  }
  dimension: percent_action_limit_reached {
    type: number
    sql: ${category_yearly_deviation_count}*100.0/NULLIF(${action_limit},0) ;;
    value_format: "0\%"
  }
  dimension: action_limit_exceeded {
    group_label: "Category Yearly Facts"
    type: yesno
    description: "Annual limit to deviations hit or exceeded"
    sql: ${action_limit}<=${category_yearly_deviation_count} ;;
  }

  measure: count_action_limit_exceeded {
    description: "Annual limit to deviations hit or exceeded"
    type: count
    filters: {
      field: action_limit_exceeded
      value: "Yes"
    }
    drill_fields: [fact_deviations.date_created_year, event_classification, action_limit, percent_action_limit_reached, fact_deviations.count]
  }
}
