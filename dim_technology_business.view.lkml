view: dim_technology_business {
  sql_table_name: dbo.DIM_technology_business ;;

  dimension: active_flag {
    type: string
    sql: ${TABLE}.ACTIVE_FLAG ;;
  }

  dimension: technology_business_key {
    type: number
    sql: ${TABLE}.technology_business_KEY ;;
  }

  dimension: technology_business_name {
    type: string
    sql: ${TABLE}.technology_business_NAME ;;
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
    sql: ${TABLE}.INSERT_DATE ;;
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
    sql: ${TABLE}.UPDATE_DATE ;;
  }

  measure: count {
    type: count
    drill_fields: [technology_business_name]
  }
}
