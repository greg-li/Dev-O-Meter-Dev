view: dim_causal {
  sql_table_name: dbo.DIM_CAUSAL ;;

  dimension: active_flag {
    type: string
    sql: ${TABLE}.ACTIVE_FLAG ;;
  }

  dimension: causal_key {
    type: number
    sql: ${TABLE}.CAUSAL_KEY ;;
  }

  dimension: causal_name {
    type: string
    sql: ${TABLE}.CAUSAL_NAME ;;
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
    drill_fields: [causal_name]
  }
}
