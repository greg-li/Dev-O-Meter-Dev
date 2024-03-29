view: dim_lot_batch {
  sql_table_name: dbo.DIM_LOT_BATCH ;;

  dimension: active_flag {
    type: string
    sql: ${TABLE}.ACTIVE_FLAG ;;
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


  dimension: lot_batch {          ##keep
    type: string
    sql: ${TABLE}.LOT_BATCH ;;
  }

  dimension: lot_key {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.LOT_KEY ;;
  }



  measure: count {
    type: count
    drill_fields: []
  }
}