view: msat_weekly_data {
  derived_table: {
    sql: select
        'MSAT' as AssetFunction
        ,MonthEndingDate
        ,ProjectedToBeLate as Projected_To_Be_Late
        ,AtRisk as At_Risk
        ,OnTrack as On_Track
        ,ProjectedToBeLate+AtRisk+OnTrack as Deliverable_Total
        ,YTDReleaseTarget
        ,YTDReleaseActual
        from datalake.SLTWeeklyDataEntry_Excel_MSAT
        where LoadID = (
        select max(loadID) from dataLake.SLTWeeklyDataEntry_Excel_MSAT)
       ;;
    persist_for: "24 hours"
  }


  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: ttl_at_risk {
    label: "Deliverables at Risk"
    type:  sum
    sql: ${TABLE}.at_risk ;;
  }

  measure: ttl_projected_to_be_late {
    label: "Deliverables Projected to be Late"
    type:  sum
    sql: ${TABLE}.projected_to_be_late ;;
  }

  measure: ttl_on_track {
    label: "Deliverables On-Track"
    type:  sum
    sql: ${TABLE}.on_track ;;
  }

  measure: total_deliverables {
    label: "Total Deliverables"
    type:  sum
    sql: ${TABLE}.deliverable_total ;;
  }

  measure: remaining_deliverables {
    label: "Remaining Deliverables"
    type: sum
    sql: ${deliverable_total}-${on_track}-${projected_to_be_late}-${at_risk};;

  }

  measure: releases {
    label: "Actual Releases"
    type:  sum
    sql: ${TABLE}.YTDReleaseActual;;
  }

  measure: releases_target {
    label: "Target Releases"
    type:  sum
    sql: ${TABLE}.YTDReleaseTarget;;
  }

  measure: remaining_releases {
    label: "Remaining Releases"
    type: number
    sql: ${releases_target}-${releases} ;;

  }

  dimension: asset_function {
    type: string
    sql: ${TABLE}.AssetFunction ;;
  }

  dimension_group: month_ending_date {
    type: time
    sql: ${TABLE}.MonthEndingDate ;;
  }

  dimension: projected_to_be_late {
    type: number
    sql: ${TABLE}.Projected_To_Be_Late ;;
  }

  dimension: at_risk {
    type: number
    sql: ${TABLE}.At_Risk ;;
  }

  dimension: on_track {
    type: number
    sql: ${TABLE}.On_Track ;;
  }

  dimension: deliverable_total {
    type: number
    sql: ${TABLE}.Deliverable_Total ;;
  }

  dimension: ytdrelease_target {
    type: number
    sql: ${TABLE}.YTDReleaseTarget ;;
  }

  dimension: ytdrelease_actual {
    type: number
    sql: ${TABLE}.YTDReleaseActual ;;
  }

  dimension_group: msat_date {
    label: "MSAT Month Date"
    timeframes: [date,month_name, month,quarter,quarter_of_year,year]
    type: time
    sql: ${TABLE}.MonthEndingDate ;;
  }


  set: detail {
    fields: [
      asset_function,
      month_ending_date_time,
      projected_to_be_late,
      at_risk,
      on_track,
      deliverable_total,
      ytdrelease_target,
      ytdrelease_actual
    ]
  }
}
