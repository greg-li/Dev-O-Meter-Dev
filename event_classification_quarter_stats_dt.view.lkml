# Purpose: Get count of SA Investigation Required
# This builds from event_classification_month_stats_dt and aggregates at the quarter
explore: event_classification_quarter_stats_dt {hidden:yes}
view: event_classification_quarter_stats_dt {
  derived_table: {
    explore_source: event_classification_month_stats_dt {
      column: date_created_quarter {}
      column: count_alert_limit_exceeded {}
      column: event_class_key {}
    }
  }
  dimension: pk {
    hidden: yes
    primary_key: yes
    sql: concat(${event_class_key},'-',${date_created_quarter}) ;;
  }
  dimension: date_created_quarter {
    hidden: yes
    type: date_quarter
  }
  dimension: count_alert_limit_exceeded {
    label: "Count Months where Alert Limit Exceeded"
    group_label: "Category Quarterly Facts"
    description: "Count of months in quarter per category where deviations exceeded"
    type: number
  }
  dimension: event_class_key {
    hidden: yes
  }
  dimension: sa_investigation_required {
    label: "SA Investigation Required"
    group_label: "Category Quarterly Facts"
    type: yesno
    sql: ${count_alert_limit_exceeded}>=2 ;;
  }
  measure: count_sa_investigation_required {
    label: "Count SA Investigation Required"
    group_label: "Category Quarterly Facts"
    type: count
    filters: {
      field: sa_investigation_required
      value: "Yes"
    }
    drill_fields: [detail*]
  }
  set: detail {
    fields: [
      date_created_quarter
      , dim_event_classification.event_classification
      , event_classification_month_stats_dt.count_alert_limit_exceeded
#       , dim_event_classification.alert_limit
#       , event_classification_month_stats_dt.category_monthly_deviation_count
#       , fact_deviations.count
    ]
  }
}
