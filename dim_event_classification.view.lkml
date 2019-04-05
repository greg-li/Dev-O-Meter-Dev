explore: dim_event_classification {hidden:yes}
view: dim_event_classification {

  sql_table_name: dbo.DIM_EVENT_CLASSIFICATION ;;

  dimension: event_class_key{
    primary_key: yes
#     hidden: yes
    type: number
    sql: ${TABLE}.EVENT_CLASS_KEY ;;
  }
  dimension: bus_sec_key{
    hidden: yes
    type: number
    sql: ${TABLE}.BUS_SEC_KEY ;;
  }
  dimension: site_key{
    hidden: yes
    type: number
    sql: ${TABLE}.SITE_KEY ;;
  }

  dimension: event_classification {
    label: "Event Category Name"
    type: string
    sql: ${TABLE}.EVENT_CLASSIFICATION ;;
  }
  dimension: event_area{
    label: "Event General Category"
    type: string
    sql: ${TABLE}.EVENT_AREA ;;
  }
  dimension: action_limit {
    label: "Event Action Limit"
    description: "Annual Deviation Limit"
    group_label: "Category Yearly Facts"
    type: number
    sql: ${TABLE}.EVENT_LIMIT ;;
  }
  measure: count {
    type: count
  }
  dimension: alert_limit  { # Using this instead of alert_limit_check.alert_limit
    group_label: "Category Monthly Facts"
#   label: "Category Monthly Limit"
    description: "Category Monthly Limit AKA Alert Limit"
    type:  number
    sql: ${TABLE}.EVENT_MONTH_LIMIT;;
  }

  dimension_group: effective {
    label: "Event Effective"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: cast(${TABLE}.EFFECTIVE_DATE AT TIME ZONE 'UTC' AT TIME ZONE {% parameter fact_deviations.timezone_selection %} as datetime2) ;;
  }


  dimension_group: insert {
    hidden: yes
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: cast(${TABLE}.INSERT_DATE AT TIME ZONE 'UTC' AT TIME ZONE {% parameter fact_deviations.timezone_selection %} as datetime2) ;;
  }

  dimension_group: update {
    hidden: yes
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: cast(${TABLE}.UPDATE_DATE AT TIME ZONE 'UTC' AT TIME ZONE {% parameter fact_deviations.timezone_selection %} as datetime2) ;;
  }


  dimension: active_flag {
    label: "Event Active Flag"
    type: string
    sql: ${TABLE}.ACTIVE_FLAG ;;
  }
  measure: total_alert_limit {
    label: "Total Event Alert Limit"
    type: sum
    sql: ${alert_limit} ;;
  }
}
