view: deviations_target_month {
  view_label: " Deviations Targets"
  derived_table: {
    sql: SELECT
        calendar.month AS "target_month"
        , calendar.baseline_year AS "calendar_baseline_year"
        , annual_fact_deviations.site_name  AS "site_name"
        , YEAR(annual_fact_deviations.baseline_year)  AS "baseline_year"
        , annual_fact_deviations.annual_deviations  AS "annual_deviations"

      FROM
        ${annual_fact_deviations.SQL_TABLE_NAME} AS annual_fact_deviations

      LEFT OUTER JOIN
        ${monthly_calendar.SQL_TABLE_NAME} AS calendar
        ON calendar.baseline_year = YEAR(annual_fact_deviations.baseline_year)
        ;;
  }

  dimension: pk {
    hidden: yes
    primary_key: yes
    sql: CONCAT(${TABLE}.target_month, ${TABLE}.site_name) ;;
  }

  dimension_group: target {
    hidden: yes
    type: time
    datatype: datetime
    timeframes: [month]
    sql: ${TABLE}.target_month ;;
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
    description: "Total number of deviations seen in the previous or baseline year"
    type: sum_distinct
    sql_distinct_key: ${baseline_year} ;;
    sql: ${TABLE}.annual_deviations ;;
  }

  measure: total_monthly_deviations_target {
    label: "Monthly Deviations Target"
    description: "Sum of all individual deviation targets by Site for the month"
    type: number
    sql: ${total_annual_deviations} / 12.0 * 0.8 ;;
    value_format_name: decimal_2
  }

  measure: total_annual_deviations_target {
    label: "Annual Deviations Target"
    description: "Sum of all individual deviation targets by Site for the year"
    type: number
    sql: ${total_annual_deviations} * 0.8 ;;
    value_format_name: decimal_2
  }
}
