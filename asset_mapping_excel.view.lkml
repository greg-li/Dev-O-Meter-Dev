view: asset_mapping_excel {
#   sql_table_name: dataLake.AssetMapping_Excel ;;
  derived_table: {
    sql: SELECT * FROM dataLake.AssetMapping_Excel
      where loadid = (select max(loadid) from dataLake.AssetMapping_Excel) ;;
    persist_for: "24 hours"
  }

  dimension: primary_key {
    primary_key: yes
    hidden: yes
    type: string
    sql: CONCAT(${load_id},${master},${load_date}) ;;
  }

  dimension: deviations {
    hidden: yes
    type: string
    sql: ${TABLE}.Deviations ;;
  }

  dimension: excel {
    hidden: yes
    type: string
    sql: ${TABLE}.Excel ;;
  }

  dimension_group: load {
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
    sql: ${TABLE}.LoadDate ;;
  }

  dimension: load_id {
    hidden: yes
    type: number
    sql: ${TABLE}.LoadID ;;
  }

  dimension: master {
    label: "Asset - Function"
    type: string
    sql: ${TABLE}.Master ;;
  }

  dimension: record_source {
    hidden: yes
    type: string
    sql: ${TABLE}.RecordSource ;;
  }

  dimension: safety {
    hidden: yes
    type: string
    sql: ${TABLE}.Safety ;;
  }

  measure: count {
    hidden: yes
    type: count
    drill_fields: []
  }
}
