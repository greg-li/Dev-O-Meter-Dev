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
    primary_key: yes
    sql: ${TABLE}.SITE_KEY ;;
  }

  dimension: site_name {
    type: string
   sql: ${TABLE}.SITE_NAME ;;
  }
  dimension: deviation_goal {
    type: number
    sql: ${TABLE}.DEVIATION_GOAL ;;
  }
  measure: annual_deviation_goal1 {
    type: sum
    sql: ${deviation_goal} ;;
  }
  dimension: monthly_deviation_goal {
    type: number
    sql: ${TABLE}.DEVIATION_GOAL /12.0;;
  }

  measure: monthly_deviation_goal1 {
    type: sum
    sql: ${monthly_deviation_goal};;
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
