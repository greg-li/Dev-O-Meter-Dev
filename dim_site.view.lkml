view: dim_site {
  sql_table_name: dbo.DIM_SITE ;;

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

  dimension: site_key {
    hidden: yes
    type: number
    primary_key: yes
    sql: ${TABLE}.SITE_KEY ;;
  }

  dimension: site_name {      ##keep
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

  measure: count {
    type: count
    drill_fields: [site_name]
  }



  }
