view: alert_limit_check {
  sql_table_name: dbo.Alert_Limit_Check ;;

  dimension: alert_limit {
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
    sql: cast(tzdb.utctolocal(${TABLE}.FirstOfMonth,{% parameter fact_deviations.timezone_selection %}) as datetime2);;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
