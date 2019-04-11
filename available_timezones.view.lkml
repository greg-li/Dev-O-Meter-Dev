view: available_timezones {
  derived_table: {
    sql: SELECT name, current_utc_offset, is_currently_dst FROM sys.time_zone_info
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: current_utc_offset {
    type: string
    sql: ${TABLE}.current_utc_offset ;;
  }

  dimension: is_currently_dst {
    type: string
    sql: ${TABLE}.is_currently_dst ;;
  }

  set: detail {
    fields: [name, current_utc_offset, is_currently_dst]
  }
}
