view: deviations_target {
  view_label: " Deviations Targets"
  derived_table: {
    sql: SELECT
        weekly_calendar.week AS "target_week"
        , weekly_calendar.baseline_year AS "calendar_baseline_year"
        , annual_fact_deviations.site_name  AS "site_name"
        , YEAR(annual_fact_deviations.baseline_year)  AS "baseline_year"
        , annual_fact_deviations.annual_deviations  AS "annual_deviations"

      FROM
        ${annual_fact_deviations.SQL_TABLE_NAME} AS annual_fact_deviations

      LEFT OUTER JOIN
        ${weekly_calendar.SQL_TABLE_NAME} AS weekly_calendar
        ON weekly_calendar.baseline_year = YEAR(annual_fact_deviations.baseline_year)
        ;;
  }

  dimension: pk {
    hidden: yes
    primary_key: yes
    sql: CONCAT(${TABLE}.target_week, ${TABLE}.site_name) ;;
  }

  dimension_group: target {
    hidden: yes
    type: time
    datatype: datetime
    timeframes: [week]
    sql: ${TABLE}.target_week ;;
  }

  dimension: calendar_baseline_year {
    hidden: yes
    type: number
    sql: ${TABLE}.calendar_baseline_year ;;
  }

  dimension: site_name {
    hidden: yes
    type: string
    sql: ${TABLE}.site_name ;;
  }

  dimension: baseline_year {
    hidden: yes
    type: number
    sql: ${TABLE}.baseline_year ;;
  }

  dimension: baseline_annual_deviations {
    hidden: yes
    type: number
    sql: ${TABLE}.annual_deviations ;;
  }

  measure: total_annual_deviations {
    hidden: yes
    type: sum_distinct
    sql_distinct_key: ${baseline_year} ;;
    sql: ${TABLE}.annual_deviations ;;
  }

  measure: total_weekly_deviations_target {
    label: "Weekly Deviations Target"
    description: "Sum of all individual deviation targets by Site for the week"
    type: number
    sql: ${total_annual_deviations} / 52.0 * 0.8 ;;
    value_format_name: decimal_2
 }
}
