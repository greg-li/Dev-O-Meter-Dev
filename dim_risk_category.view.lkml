view: dim_risk_category {
  sql_table_name: dbo.DIM_RISK_CATEGORY ;;

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


  dimension: risk_cat_key {
    type: number
    sql: ${TABLE}.RISK_CAT_KEY ;;
  }

  dimension: risk_category_name {
    type: string
    sql: ${TABLE}.RISK_CATEGORY_NAME ;;
  }

  measure: count {
    type: count
    drill_fields: [risk_category_name]
  }
}
