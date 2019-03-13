view: dim_area {
    sql_table_name:dbo.dim_area;;


  dimension: active_flag {
    type: string
    sql: ${TABLE}.ACTIVE_FLAG ;;
  }

  dimension: area_key {
    type: number
    sql: ${TABLE}.AREA_KEY ;;
  }

  dimension: area_name {
    type: string
    sql: ${TABLE}.AREA_NAME ;;
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
    drill_fields: [area_name]
  }
  }
