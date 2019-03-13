view: dim_deviation_type {
  sql_table_name: dbo.DIM_DEVIATION_TYPE ;;

  dimension: active_flag {
    type: string
    sql: ${TABLE}.ACTIVE_FLAG ;;
  }

  dimension: deviation_key {
    type: number
    sql: ${TABLE}.DEVIATION_KEY ;;
  }

  dimension: deviation_type {
    type: string
    sql: ${TABLE}.DEVIATION_TYPE ;;
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
    convert_tz: no
    datatype: date
    sql: cast(tzdb.utctolocal(${TABLE}.INSERT_DATE,{% parameter fact_deviations.timezone_selection %}) as datetime2) ;;
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
    convert_tz: no
    datatype: date
    sql: cast(tzdb.utctolocal(${TABLE}.UPDATE_DATE,{% parameter fact_deviations.timezone_selection %}) as datetime2) ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
