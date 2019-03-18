view: dim_deviation_type {
  sql_table_name: dbo.DIM_DEVIATION_TYPE ;;

  dimension: active_flag {
    label: "Type Active Flag"
    type: string
    sql: ${TABLE}.ACTIVE_FLAG ;;
  }

  dimension: deviation_key {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.DEVIATION_KEY ;;
  }

  dimension: deviation_type {       ##keep
    type: string
    sql: ${TABLE}.DEVIATION_TYPE ;;
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
    label: "Deviation Type Count"
    type: count
    drill_fields: []
  }
}
