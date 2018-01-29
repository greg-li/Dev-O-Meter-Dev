view: alert_limit_check {
  sql_table_name: dbo.Alert_Limit_Check ;;

  dimension: alert_limit {
    type: number
    sql: ${TABLE}.Alert_Limit ;;
  }

  dimension: event_area {
    type: string
    sql: ${TABLE}.EVENT_AREA ;;
  }

  dimension: event_class_key {
    type: number
    sql: ${TABLE}.EVENT_CLASS_KEY ;;
  }

  dimension: event_classification {
    type: string
    sql: ${TABLE}.EVENT_CLASSIFICATION ;;
  }

  dimension: cnt_dev {
    type: number
    sql: ${TABLE}.Expr1 ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
