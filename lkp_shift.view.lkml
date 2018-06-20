view: lkp_shift {
  sql_table_name: dbo.LKP_SHIFT ;;

  dimension: color_number {
    type: number
    sql: ${TABLE}.color_number ;;
  }

  dimension_group: schedule {
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
    sql: ${TABLE}.schedule_Date ;;
  }

  dimension: schedule_day {
    type: number
    sql: ${TABLE}.schedule_day ;;
  }

  dimension: schedule_month_num {
    type: number
    sql: ${TABLE}.schedule_month ;;
  }

  dimension: shift {
    type: string
    sql: ${TABLE}.shift ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
