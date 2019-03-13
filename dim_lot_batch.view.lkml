view: dim_lot_batch {
  sql_table_name: dbo.DIM_LOT_BATCH ;;

  dimension: active_flag {
    type: string
    sql: ${TABLE}.ACTIVE_FLAG ;;
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


  dimension: lot_batch {
    type: string
    sql: ${TABLE}.LOT_BATCH ;;
  }

  dimension: lot_key {
    type: number
    sql: ${TABLE}.LOT_KEY ;;
  }



  measure: count {
    type: count
    drill_fields: []
  }
}
