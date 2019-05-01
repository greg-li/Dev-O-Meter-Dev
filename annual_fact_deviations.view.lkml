view: annual_fact_deviations {
  derived_table: {
    sql: SELECT
        dim_site.site_name AS "site_name",
        asset_mapping_excel.Master  AS "master",
        YEAR(fact_deviations.DATE_CREATED) AS "deviation_created_year",
        YEAR(fact_deviations.DATE_CREATED) + 1 AS "following_year",
        COUNT(DISTINCT fact_deviations.PARENT_RECORD_ID ) as "annual_deviations",
        COUNT(DISTINCT fact_deviations.PARENT_RECORD_ID ) / 52.0 * 0.8 as "following_year_weekly_target"
      FROM ${fact_deviations.SQL_TABLE_NAME} AS fact_deviations
      LEFT JOIN dbo.DIM_SITE AS dim_site ON fact_deviations.SITE_KEY = dim_site.SITE_KEY
      LEFT JOIN dbo.DIM_DEVIATION_TYPE  AS dim_deviation_type ON fact_deviations.DEVIATION_KEY = dim_deviation_type.DEVIATION_KEY
      LEFT JOIN dbo.VW_Asset_to_Area  AS vw_asset_to_area ON fact_deviations.AREA_OCCURED_KEY = vw_asset_to_area.AREA_KEY
      LEFT JOIN ${asset_mapping_excel.SQL_TABLE_NAME} AS asset_mapping_excel ON vw_asset_to_area.Asset = asset_mapping_excel.Deviations

      WHERE
        (dim_deviation_type.DEVIATION_TYPE  IN ('Customer Complaint - Packaging and shipping complaints', 'Unplanned', 'Customer Complaint - Product quality complaints'))
      GROUP BY
        dim_site.site_name,
        asset_mapping_excel.Master,
        YEAR(fact_deviations.DATE_CREATED)
 ;;
  }

  dimension: primary_key {
    hidden: yes
    primary_key: yes
    sql: concat(${site_name}, ${asset_mapping_excel_master}, ${deviation_created_year}) ;;
  }

  dimension: site_name {
    type: string
    sql: ${TABLE}.site_name ;;
  }

  dimension: asset_mapping_excel_master {
    label: "Master Asset"
    type: string
    sql: ${TABLE}.master ;;
  }

  dimension: deviation_created_year {
    type: number
    sql: ${TABLE}.deviation_created_year ;;
  }

  dimension: following_year {
    type: number
    sql: ${TABLE}.following_year ;;
  }

  dimension: annual_deviations {
    type: number
    sql: ${TABLE}.annual_deviations ;;
  }

  dimension: following_year_weekly_target {
    type: number
    sql: ${TABLE}.following_year_weekly_target ;;
  }
}
