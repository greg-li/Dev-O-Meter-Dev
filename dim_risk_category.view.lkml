view: dim_risk_category {
  sql_table_name: dbo.DIM_RISK_CATEGORY ;;

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


  dimension: risk_cat_key {
    primary_key: yes
    hidden: yes
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