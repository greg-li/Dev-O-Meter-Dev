view: deviations_target {
  derived_table: {
    sql: SELECT
        annual_fact_deviations.master  AS "master",
        annual_fact_deviations.deviation_created_year  AS "deviation_created_year",
        annual_fact_deviations.annual_deviations  AS "annual_deviations",
        annual_fact_deviations.following_year  AS "following_year",
        annual_fact_deviations.following_year_weekly_target  AS "following_year_weekly_target",
        weekly_calendar.prior_year AS baseline_year,
        weekly_calendar.week AS deviation_week
      FROM
        ${annual_fact_deviations.SQL_TABLE_NAME} AS annual_fact_deviations

      LEFT OUTER JOIN
        ${weekly_calendar.SQL_TABLE_NAME} AS weekly_calendar
          ON weekly_calendar.prior_year = annual_fact_deviations.deviation_created_year
      ;;
  }

  dimension: primary_key {
    hidden: yes
    primary_key: yes
    sql: concat(${asset_mapping_excel_master},${baseline_year},${weekly_list_deviation_week}) ;;
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

  dimension: weekly_list_deviation_week {
    type: string
    sql: ${TABLE}.deviation_week ;;
  }

  dimension: baseline_year {
    type: number
    sql: ${TABLE}.baseline_year ;;
  }

  dimension: baseline_annual_asset_deviations {
    type: number
    sql: ${TABLE}.annual_deviations ;;
  }

  dimension: asset_weekly_deviation_target {
    type: number
    sql: ${TABLE}.following_year_weekly_target ;;
  }

  measure: total_deviation_target {
    type: sum
    sql: ${asset_weekly_deviation_target} ;;
  }
}
