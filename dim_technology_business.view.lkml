view: dim_technology_business {
  sql_table_name: dbo.DIM_technology_business ;;

  dimension: active_flag {
    hidden: yes
    type: string
    sql: ${TABLE}.ACTIVE_FLAG ;;
  }

  dimension: technology_business_key {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.technology_business_KEY ;;
  }

  dimension: technology_business_name {
    hidden: yes
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

  measure: count {
    hidden: yes
    type: count
    drill_fields: [technology_business_name]
  }
}