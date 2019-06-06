view: annual_fact_deviations {
  label: "Annual Deviations"
  derived_table: {
    sql: select site_key
          , area_occured_key
          , deviation_created_year
          , following_year
          , sum(annual_deviations) as annual_deviations
          , sum(following_year_annual_target) as following_year_annual_target
          , sum(following_year_daily_target) as following_year_daily_target
        from (
          SELECT
                fact_deviations.site_key AS "site_key",
                fact_deviations.area_occured_key as "area_occured_key",
                YEAR(fact_deviations.DATE_CREATED) AS "deviation_created_year",
                YEAR(fact_deviations.DATE_CREATED) + 1 AS "following_year",
                COUNT(DISTINCT fact_deviations.PARENT_RECORD_ID ) as "annual_deviations",
                COUNT(DISTINCT fact_deviations.PARENT_RECORD_ID ) * 0.8 as "following_year_annual_target",
                --COUNT(DISTINCT fact_deviations.PARENT_RECORD_ID ) / 12.0 * 0.8 as "following_year_monthly_target",
                --COUNT(DISTINCT fact_deviations.PARENT_RECORD_ID ) / 52.0 * 0.8 as "following_year_weekly_target"
                COUNT(DISTINCT fact_deviations.PARENT_RECORD_ID ) / 365.0 * 0.8 as "following_year_daily_target"
              FROM dbo.FACT_DEVIATIONS AS fact_deviations
            left join dbo.DIM_AREA a
            on fact_deviations.AREA_OCCURED_KEY = a.AREA_KEY
              LEFT JOIN dbo.DIM_DEVIATION_TYPE  AS dim_deviation_type ON fact_deviations.DEVIATION_KEY = dim_deviation_type.DEVIATION_KEY
              LEFT JOIN dbo.DIM_DEVIATION_STATUS  AS dim_deviation_status ON fact_deviations.DEV_STATUS_KEY = dim_deviation_status.DEV_STATUS_KEY
               WHERE
                (dim_deviation_type.DEVIATION_TYPE  IN ('Customer Complaint - Packaging and shipping complaints', 'Unplanned', 'Customer Complaint - Product quality complaints'))
                  and dim_deviation_status.DEVIATION_STATUS  NOT IN ('Closed - Aborted', 'Closed - Cancelled', 'Closed - Voided')
                --and asset_mapping_excel.Master != 'P5'
              GROUP BY
                fact_deviations.site_key,
                fact_deviations.area_occured_key,
                YEAR(fact_deviations.DATE_CREATED)

            UNION ALL

            select SITE_KEY
              , AREA_OCCURED_KEY
              , deviation_created_year
              , deviation_created_year + 1
              , 0
              , 0
              , 0
          from (
            select distinct site_key
              , area_occured_key
            from dbo.FACT_DEVIATIONS
            ) siteArea
          , (
            select distinct(year(date_created)) deviation_created_year
            from dbo.FACT_DEVIATIONS
          ) years
        ) x
        group by site_key
          , area_occured_key
          , deviation_created_year
          , following_year;;
  }

  dimension: primary_key {
    hidden: yes
    primary_key: yes
    sql: concat(${site_key}, ${area_occured_key}, ${deviation_created_year}) ;;
  }

  dimension: site_key {
    type: number
    sql: ${TABLE}.site_key ;;
  }

  dimension: area_occured_key {
    type: number
    sql: ${TABLE}.area_occured_key ;;
  }

  dimension: deviation_created_year {
    label: "Baseline Year"
    type: number
    sql: ${TABLE}.deviation_created_year ;;
  }

  dimension: following_year {
    label: "Target Year"
    type: number
    sql: ${TABLE}.following_year ;;
  }

  dimension: annual_deviations {
    type: number
    sql: ${TABLE}.annual_deviations ;;
  }

  dimension: following_year_annual_target {
    type: number
    sql: ${TABLE}.following_year_annual_target ;;
  }

  dimension: following_year_daily_target {
    type: number
    sql: ${TABLE}.following_year_daily_target ;;
  }

  measure: total_annual_deviations_target {
    type: sum
    sql: ${following_year_annual_target} ;;
    value_format_name: decimal_2
  }

  measure: total_daily_deviations_target {
    type: sum
    sql: ${following_year_daily_target} ;;
    value_format_name: decimal_2
  }
}
