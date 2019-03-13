view: dim_root_cause {
  sql_table_name: dbo.DIM_ROOT_CAUSE ;;

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

  dimension: root_cause_category {
    type: string
    drill_fields: [root_cause_name]
    sql: ${TABLE}.ROOT_CAUSE_CATEGORY ;;
  }

  dimension: root_cause_key {
    type: number
    sql: ${TABLE}.ROOT_CAUSE_KEY ;;
  }

  dimension: root_cause_name {
    type: string
    sql: ${TABLE}.ROOT_CAUSE_NAME ;;
  }


  measure: count {
    type: count
    drill_fields: [root_cause_name]
  }
}
