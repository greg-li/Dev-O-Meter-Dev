view: dim_area_group {
  sql_table_name: dbo.DIM_Area_Group ;;

  dimension: area_responsible {
    type: string
    sql: ${TABLE}."Area Responsible" ;;
  }

  dimension: group {
    type: string
    sql: ${TABLE}."Group" ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
