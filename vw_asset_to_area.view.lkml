view: vw_asset_to_area {
  sql_table_name: dbo.VW_Asset_to_Area ;;

  dimension: area {
    type: string
    sql: ${TABLE}.Area ;;
  }

  dimension: area_key {
    hidden: yes
    type: number
    sql: ${TABLE}.AREA_KEY ;;
  }

  dimension: asset {
    type: string
    sql: ${TABLE}.Asset ;;
  }

  dimension: unique_id {
    primary_key: yes
    hidden: yes
    sql: concat(${area},${area_key},${asset});;
  }

  measure: count {
    hidden: yes
    type: count
    drill_fields: []
  }
}
