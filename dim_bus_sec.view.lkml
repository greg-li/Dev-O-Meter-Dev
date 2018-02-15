view: dim_bus_sec {
  sql_table_name: dbo.DIM_BUS_SEC ;;

  dimension: active_flag {
    type: string
    sql: ${TABLE}.ACTIVE_FLAG ;;
  }

  dimension: bus_sec_key {
    type: number
    sql: ${TABLE}.BUS_SEC_KEY ;;
  }

  dimension: bus_sec_name {
    type: string
    sql: ${TABLE}.BUS_SEC_NAME ;;
  }

  dimension_group: insert {
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
    sql: ${TABLE}.INSERT_DATE ;;
  }

  dimension_group: update {
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
    sql: ${TABLE}.UPDATE_DATE ;;
  }

  measure: count {
    type: count
    drill_fields: [bus_sec_name]
  }
}
