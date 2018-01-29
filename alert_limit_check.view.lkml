view: alert_limit_check {
  sql_table_name: dbo.Alert Limit Check ;;

  dimension: alert_limit {
    type: number
    sql: ${TABLE}.Alert_Limit ;;
  }

  dimension: event_area {
    type: string
    sql: ${TABLE}.EVENT_AREA ;;
  }

  dimension: event_classification {
    type: string
    sql: ${TABLE}.EVENT_CLASSIFICATION ;;
  }

  dimension: expr1 {
    type: number
    sql: ${TABLE}.Expr1 ;;
  }
  dimension: alert_flag {
    type: yesno
    sql: ${TABLE}.Expr1 >${alert_limit};;
  }
  measure: count {
    type: count
    drill_fields: []
  }
}
