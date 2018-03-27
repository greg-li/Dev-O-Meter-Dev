view: rpt_asset {
  sql_table_name: dbo.RPT_Asset ;;

  dimension: area {
    type: string
    sql: ${TABLE}.Area ;;
  }

  dimension: asset {
    type: string
    sql: ${TABLE}.Asset ;;
  }
  dimension: area_key {
    type: string
    sql: ${TABLE}.AREA_KEY;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
