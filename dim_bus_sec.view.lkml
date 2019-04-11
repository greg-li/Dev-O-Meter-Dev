view: dim_bus_sec {
  sql_table_name: dbo.DIM_BUS_SEC ;;
  view_label: "Business Sector"

  dimension: active_flag {
    type: string
    sql: ${TABLE}.ACTIVE_FLAG ;;
  }

  dimension: bus_sec_key {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.BUS_SEC_KEY ;;
  }

  dimension: bus_sec_name {           ##keep
    label: "Business Sector Unit"
    type: string
    sql: ${TABLE}.BUS_SEC_NAME ;;
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
    type: count
    drill_fields: [bus_sec_name]
  }
}