view: msat_weekly_data {
  derived_table: {
    sql: select
        'MSAT' as AssetFunction
          ,WeekEndingDate
        ,ProjectedToBeLate
          ,AtRisk
        ,OnTrack
        ,ProjectedToBeLate+AtRisk+OnTrack as DeliverableTotal
         from datalake.SLTWeeklyDataEntry_Excel_MSAT
        where LoadID = (
          select max(loadID) from dataLake.SLTWeeklyDataEntry_Excel_MSAT)
       ;;
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

  dimension: asset_function {
    type: string
    sql: ${TABLE}.AssetFunction ;;
  }

  dimension_group: week_ending_date {
    type: time
    sql: ${TABLE}.WeekEndingDate ;;
  }

  dimension: projected_to_be_late {
    type: number
    sql: ${TABLE}.ProjectedToBeLate ;;
  }

  dimension: at_risk {
    type: number
    sql: ${TABLE}.AtRisk ;;
  }

  dimension: on_track {
    type: number
    sql: ${TABLE}.OnTrack ;;
  }

  dimension: deliverable_total {
    type: number
    sql: ${TABLE}.DeliverableTotal ;;
  }

  set: detail {
    fields: [
      asset_function,
      week_ending_date_time,
      projected_to_be_late,
      at_risk,
      on_track,
      deliverable_total
    ]
  }
}
