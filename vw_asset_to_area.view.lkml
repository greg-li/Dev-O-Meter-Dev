view: vw_asset_to_area {
  sql_table_name: dbo.VW_Asset_to_Area ;;

  dimension: area {
    type: string
    sql: ${TABLE}.Area ;;
  }

  dimension: area_key {
    type: number
    sql: ${TABLE}.AREA_KEY ;;
  }

  dimension: asset {
    type: string
    sql: ${TABLE}.Asset ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
