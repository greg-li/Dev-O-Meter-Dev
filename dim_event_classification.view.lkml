view: dim_event_classification {

  sql_table_name: dbo.DIM_EVENT_CLASSIFICATION ;;

  dimension: event_class_key{
    hidden: yes
    type: number
    sql: ${TABLE}.EVENT_CLASS_KEY ;;
  }

  dimension: event_classification {
    label: "Event Category Name"
    type: string
    sql: ${TABLE}.EVENT_CLASSIFICATION ;;
  }
  dimension: event_area{
    label: "Event General Category"
    type: string
    sql: ${TABLE}.EVENT_AREA ;;
  }
  dimension: Action_Limit{
    label: "Event Action Limit"
    type: number
    sql: ${TABLE}.EVENT_LIMIT ;;
  }
dimension: Alert_Limit  {
  label: "Event Month Limit"
  type:  number
  sql: ${TABLE}.EVENT_MONTH_LIMIT;;
}

  dimension_group: effective {
    label: "Event Effective"
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
    sql: cast(tzdb.utctolocal(${TABLE}.EFFECTIVE_DATE,{% parameter fact_deviations.timezone_selection %}) as datetime2) ;;
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


  dimension: active_flag {
    label: "Event Active Flag"
    type: string
    sql: ${TABLE}.ACTIVE_FLAG ;;
  }
  measure: Alert_limit {
    label: "Total Event Alert Limit"
    type: sum
    sql: sum(${Alert_Limit} ;;
  }
}
