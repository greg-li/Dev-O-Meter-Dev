view: dim_deviation_status {
  sql_table_name: dbo.DIM_DEVIATION_STATUS ;;

  dimension: active_flag {
    hidden: yes
    label: "{% if _view._name == 'DIM_DEVIATION_STATUS' %} Deviation Status Active Flag {% else %} Deviation Type Alert Flag {% endif %}"
    type: string
    sql: ${TABLE}.ACTIVE_FLAG ;;
  }

  dimension: dev_status_key {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.DEV_STATUS_KEY ;;
  }

  dimension: deviation_status {       ##keep
    type: string
    sql: ${TABLE}.DEVIATION_STATUS ;;
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
    label: "{% if _view._name == 'DIM_DEVIATION_STATUS' %}Deviation Status Count {% else %}Deviation Type Count {% endif %}"
    type: count
    drill_fields: []
  }
}