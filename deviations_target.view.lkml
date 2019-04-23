view: deviations_target {
  derived_table: {
    sql: -- use existing asset_mapping_excel in looker_scratch.LR$MZCRVN2H2O06MKVJTN1EC_asset_mapping_excel

      SELECT
        asset_mapping_excel.Master  AS "asset_mapping_excel.master",
        YEAR(cast(fact_deviations.DATE_CREATED AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' as datetime2)) AS "fact_deviations.date_created_year",
        ((COUNT(DISTINCT fact_deviations.PARENT_RECORD_ID ))*.8)/52 AS "deviation target"
      FROM ${fact_deviations.SQL_TABLE_NAME} as fact_deviations
      LEFT JOIN dbo.DIM_DEVIATION_TYPE  AS dim_deviation_type ON fact_deviations.DEVIATION_KEY = dim_deviation_type.DEVIATION_KEY
      LEFT JOIN dbo.VW_Asset_to_Area  AS vw_asset_to_area ON fact_deviations.AREA_OCCURED_KEY = vw_asset_to_area.AREA_KEY
      LEFT JOIN ${asset_mapping_excel.SQL_TABLE_NAME} AS asset_mapping_excel ON vw_asset_to_area.Asset=asset_mapping_excel.Deviations

      WHERE
        (dim_deviation_type.DEVIATION_TYPE  IN ('Customer Complaint - Packaging and shipping complaints', 'Unplanned', 'Customer Complaint - Product quality complaints'))
      GROUP BY asset_mapping_excel.Master ,YEAR(cast(fact_deviations.DATE_CREATED AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' as datetime2))
       ;;

      persist_for: "4000 hours"
  }

  measure: count {
    hidden: yes
    type: count
    drill_fields: [detail*]
  }

  dimension: asset_mapping_excel_master {
    label: "Master Asset"
    hidden: yes
    type: string
    sql: ${TABLE}."asset_mapping_excel.master" ;;
  }

  dimension: fact_deviations_date_created_year {
    label: "Prior Year"
    hidden: yes
    type: number
    sql: ${TABLE}."fact_deviations.date_created_year" ;;
  }

  dimension: deviation_target {
    type: number
    label: "Weekly Deviation Target"
    sql: ${TABLE}."deviation target" ;;
  }

  measure: total_deviation_target {
    type: sum
    sql: ${deviation_target};;
  }

  set: detail {
    fields: [asset_mapping_excel_master, fact_deviations_date_created_year, deviation_target]
  }
}
