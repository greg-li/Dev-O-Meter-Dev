view: dim_area {
  derived_table:{
    sql: Select dim_area.active_flag,
    dim_area.area_key,
    dim_area.area_name,
    dim_area.insert_date,
    dim_area.update_date,
    dim_area_group.[group]
    from dbo.dim_area join dbo.dim_area_group on dim_area.area_name = dim_area_group.[Area Responsible];;
  }

  dimension: active_flag {
    type: string
    sql: ${TABLE}.ACTIVE_FLAG ;;
  }

  dimension: area_key {
    type: number
    sql: ${TABLE}.AREA_KEY ;;
  }

  dimension: area_name {
    type: string
    sql: ${TABLE}.AREA_NAME ;;
  }
  dimension: Area_Group {
    type: string
    sql: ${TABLE}.[Group] ;;
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

  dimension_group: update {
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
    sql: ${TABLE}.UPDATE_DATE ;;
  }

  measure: count {
    type: count
    drill_fields: [area_name]
  }
}
