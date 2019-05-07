view: asset_mapping_excel {
#   sql_table_name: dataLake.AssetMapping_Excel ;;
  derived_table: {
    sql: SELECT * FROM dataLake.AssetMapping_Excel
      where loadid = (select max(loadid) from dataLake.AssetMapping_Excel) ;;
    persist_for: "24 hours"
    indexes: ["loadid","master","loaddate"]
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
    sql: CASE WHEN ${TABLE}.Deviations IS NULL THEN 'Unassigned' ELSE ${TABLE}.Deviations END ;;
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
#     sql: ${TABLE}.Master ;;
    sql: CASE WHEN ${TABLE}.Master IS NULL THEN 'Unassigned' ELSE ${TABLE}.Master END ;;
    link: {
      label: "Safety Summary Dashboard"
      url: "/dashboards/34?&Function={{ value }}"
      icon_url: "https://www.chichester-hockey.co.uk/wp-content/uploads/2013/09/safety-first-icon.png"
    }
    link: {
      label: "Safety Drill-Down Detail"
      url: "/embed/dashboards/BT3mOTvoQJpHAPQOsRO1i5?&Function={{ value }}"
      icon_url: "http://icons.iconarchive.com/icons/iconsmind/outline/512/Down-2-2-icon.png"
    }
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
