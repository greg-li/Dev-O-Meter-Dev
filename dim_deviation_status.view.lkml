view: dim_deviation_status {
  sql_table_name: dbo.DIM_DEVIATION_STATUS ;;

  dimension: active_flag {
    label: "Status Active Flag"
    type: string
    sql: ${TABLE}.ACTIVE_FLAG ;;
  }

  dimension: dev_status_key {
    hidden: yes
    type: number
    sql: ${TABLE}.DEV_STATUS_KEY ;;
  }

  dimension: deviation_status {       ##keep
    type: string
    sql: ${TABLE}.DEVIATION_STATUS ;;
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
    sql: cast(tzdb.utctolocal(${TABLE}.INSERT_DATE,{% parameter fact_deviations.timezone_selection %}) as datetime2) ;;
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
    sql: cast(tzdb.utctolocal(${TABLE}.UPDATE_DATE,{% parameter fact_deviations.timezone_selection %}) as datetime2) ;;
  }

  measure: count {
    label: "Deviation Status Count"
    type: count
    drill_fields: []
  }
}
