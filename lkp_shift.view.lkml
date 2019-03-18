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
    convert_tz: no
    datatype: date
    sql: cast(tzdb.utctolocal(${TABLE}.schedule_Date,{% parameter fact_deviations.timezone_selection %}) as datetime2) ;;
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

  dimension: unique_id {
    primary_key: yes
    hidden: yes
    sql: concat(${color_number},${schedule_raw},${schedule_day},${schedule_month_num},${shift});;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
