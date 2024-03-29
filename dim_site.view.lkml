view: dim_site {
  sql_table_name: dbo.DIM_SITE ;;

  dimension: active_flag {
    hidden: yes
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
    hidden: yes
    type: number
    sql: ${TABLE}.DEVIATION_GOAL ;;
  }
  measure: annual_deviation_goal1 {
    label: "Annual Deviation Goal"
    type: sum
    sql: ${deviation_goal} ;;
  }
  dimension: monthly_deviation_goal {
    hidden: yes
    type: number
    sql: ${TABLE}.DEVIATION_GOAL /12.0;;
  }

  measure: monthly_deviation_goal1 {
    label: "Monthly Deviation Goal"
    type: sum
    sql: ${monthly_deviation_goal};;
  }

  measure: count {
    hidden: yes
    type: count
    drill_fields: [site_name]
  }



  }