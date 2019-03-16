view: dim_technology_business {
  sql_table_name: dbo.DIM_technology_business ;;

  dimension: active_flag {
    type: string
    sql: ${TABLE}.ACTIVE_FLAG ;;
  }

  dimension: technology_business_key {
    hidden: yes
    type: number
    sql: ${TABLE}.technology_business_KEY ;;
  }

  dimension: technology_business_name {
    type: string
    sql: ${TABLE}.technology_business_NAME ;;
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
    type: count
    drill_fields: [technology_business_name]
  }
}
