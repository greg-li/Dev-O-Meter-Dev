view: alert_limit_check {
  sql_table_name: dbo.Alert_Limit_Check ;;

  parameter: timezone_selection {
    type: string
    suggest_explore: available_timezones
    suggest_dimension: available_timezones.name
  }

  dimension: alert_limit { # Use dim_event_classification.Alert_Limit instead
    hidden: yes
    type: number
    sql: ${TABLE}.Alert_Limit ;;
  }

  dimension: event_area {                     ##keep
    type: string
    sql: ${TABLE}.EVENT_AREA ;;
  }

  dimension: event_class_key {
    hidden: yes
    type: number
    sql: ${TABLE}.EVENT_CLASS_KEY ;;
  }

  dimension: event_classification {            ##keep
    type: string
    sql: ${TABLE}.EVENT_CLASSIFICATION ;;
  }

  dimension: cnt_dev {
    type: number
    hidden: yes
    sql: ${TABLE}.Expr1 ;;
  }

  dimension:alert_flag{
    type: yesno
    sql: ${TABLE}.Expr1>${alert_limit} ;;
  }

  dimension_group: month_date {
    label: "First of Month"
    type: time
    timeframes: [
      raw,
      date,
      time,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: cast(${TABLE}.FirstofMonth AT TIME ZONE 'UTC' AT TIME ZONE {% parameter timezone_selection %} as datetime2) ;;
  }

  dimension: unique_id {
    primary_key: yes
    hidden: yes
    sql: CONCAT(${alert_limit},${cnt_dev},${event_area},${event_class_key},${event_classification},${month_date_raw}) ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
