view: dim_site {
  sql_table_name: dbo.DIM_SITE ;;

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
    sql: ${TABLE}.INSERT_DATE ;;
  }

  dimension: site_key {
    type: number
    sql: ${TABLE}.SITE_KEY ;;
  }

  dimension: site_name {
    type: string
    sql: ${TABLE}.SITE_NAME ;;
  }
  dimension: annual_deviation_goal {
    type: number
    sql: ${TABLE}.DEVIATION_GOAL ;;
  }
  dimension: monthly_deviation_goal {
    type: number
    sql: ${TABLE}.DEVIATION_GOAL /12;;
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
    drill_fields: [site_name]
  }
}
