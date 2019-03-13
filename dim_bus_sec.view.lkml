view: dim_bus_sec {
  sql_table_name: dbo.DIM_BUS_SEC ;;
  view_label: "Business Sector"

  dimension: active_flag {
    type: string
    sql: ${TABLE}.ACTIVE_FLAG ;;
  }

  dimension: bus_sec_key {
    type: number
    sql: ${TABLE}.BUS_SEC_KEY ;;
  }

  dimension: bus_sec_name {
    label: "Business Sector Unit"
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
    drill_fields: [bus_sec_name]
  }
}
