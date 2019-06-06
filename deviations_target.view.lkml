view: deviations_target {
  derived_table: {
    sql: SELECT
        annual_fact_deviations.site_key  AS "site_key",
        annual_fact_deviations.area_occured_key  AS "area_occured_key",
        annual_fact_deviations.deviation_created_year  AS "deviation_created_year",
        annual_fact_deviations.annual_deviations  AS "annual_deviations",
        annual_fact_deviations.following_year  AS "following_year",
        annual_fact_deviations.following_year_daily_target  AS "following_year_daily_target",
        daily_calendar.prior_year AS baseline_year,
        daily_calendar.date AS deviation_date
      FROM ${daily_calendar.SQL_TABLE_NAME} AS daily_calendar
      LEFT OUTER JOIN ${annual_fact_deviations.SQL_TABLE_NAME} AS annual_fact_deviations
          ON daily_calendar.prior_year = annual_fact_deviations.deviation_created_year
      ;;
    persist_for: "48 hours"
  }

  dimension: primary_key {
    hidden: yes
    primary_key: yes
    sql: concat(${site_key}, ${area_occured_key}, ${site_key}, ${baseline_year}, ${daily_list_deviation_date}) ;;
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
    type: number
    sql: ${TABLE}.deviation_created_year ;;
  }

  dimension_group: daily_list_deviation {
    label: "Target"
    type: time
    timeframes: [
      raw,
      date,
      week,
      week_of_year,
      month,
      month_name,
      quarter,
      year,
      day_of_week
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.deviation_date ;;
  }

  dimension: baseline_year {
    type: number
    sql: ${TABLE}.baseline_year ;;
  }

  dimension: following_year {
    type: number
    sql: ${TABLE}.following_year ;;
  }

  dimension: baseline_annual_asset_deviations {
    type: number
    sql: ${TABLE}.annual_deviations ;;
  }

  dimension: asset_daily_deviation_target {
    type: number
    sql: ${TABLE}.following_year_daily_target ;;
  }

#   dimension: asset_monthly_deviation_target{
#     type: number
#     sql: ${TABLE}.following_year_monthly_target ;;
#   }

  measure: total_daily_deviations_target {
    label: "Daily Deviations Target"
    description: "Sum of all individual deviation targets by Site and Asset for the date"
    type: sum
    sql: ${asset_daily_deviation_target} ;;
    value_format_name: decimal_2
  }


#   measure: total_monthly_deviations_target {
#     label: "Monthly Deviations Target"
#     description: "Sum of all individual deviation targets by Site and Asset for the Month"
#     type: sum
#     sql: ${asset_monthly_deviation_target} ;;
#     value_format_name: decimal_2
#   }

}
