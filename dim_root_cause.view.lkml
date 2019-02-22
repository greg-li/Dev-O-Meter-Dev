view: dim_root_cause {
  sql_table_name: dbo.DIM_ROOT_CAUSE ;;

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

  dimension: root_cause_category {
    type: string
    drill_fields: [root_cause_name]
    sql: ${TABLE}.ROOT_CAUSE_CATEGORY ;;
  }

  dimension: root_cause_key {
    type: number
    sql: ${TABLE}.ROOT_CAUSE_KEY ;;
  }

  dimension: root_cause_name {
    label: "ROOT CAUSE -- NAME"
    type: string
    sql: ${TABLE}.ROOT_CAUSE_NAME ;;
  }

  dimension: update_date {
    type: string
    sql: ${TABLE}.UPDATE_DATE ;;
  }

  measure: count {
    type: count
    drill_fields: [root_cause_name]
  }
}
