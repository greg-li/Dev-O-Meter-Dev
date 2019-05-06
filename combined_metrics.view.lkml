view: combined_metrics {
  derived_table: {
    sql: select AssetFunction
        , ScheduleAdherenceActual
        , ScheduleAdherenceTarget
        , YTDReleaseActual
        , YTDReleaseTarget
        , OpenReqsActual
        , OpenReqsTarget
        , WeekEndingDate
    , Commentary
      from dataLake.SLTWeeklyDataEntry_Excel_Mfg
    where LoadID = (
    select max(loadID) from dataLake.SLTWeeklyDataEntry_Excel_Mfg
    )

      union all

      select 'MSAT'
        , null
        , null
        , YTDReleaseActual
        , YTDReleaseTarget
        , OpenReqsActual
        , OpenReqsTarget
        , MonthEndingDate
    , Commentary
      from datalake.SLTWeeklyDataEntry_Excel_MSAT
    where LoadID = (
    select max(loadID) from dataLake.SLTWeeklyDataEntry_Excel_MSAT
    )

      union all

      select 'PP&L'
        , OTIFActual
        , OTIFTarget
        , ReceiptNumberActual
        , ReceiptNumberTarget
        , OpenReqsActual
        , OpenReqsTarget
        , WeekEndingDate
    , Commentary
      from dataLake.SLTWeeklyDataEntry_Excel_PPL
    where LoadID = (
    select max(loadID) from dataLake.SLTWeeklyDataEntry_Excel_PPL
    )

      union all

      select 'QC'
        , ScheduleAdherenceActual
        , ScheduleAdherenceTarget
        , OTIFDeliverablesActual
        , OTIFDeliverablesTarget
        , OpenReqsActual
        , OpenReqsTarget
        , WeekEndingDate
    , Commentary
      from datalake.SLTWeeklyDataEntry_Excel_QC
    where LoadID = (
    select max(loadID) from dataLake.SLTWeeklyDataEntry_Excel_QC
    )
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: asset_function {
    type: string
    sql: ${TABLE}.AssetFunction ;;
  }

  dimension: schedule_adherence_actual {
    type: number
    sql: ${TABLE}.ScheduleAdherenceActual ;;
  }

  dimension: schedule_adherence_target {
    type: number
    sql: ${TABLE}.ScheduleAdherenceTarget ;;
  }

  dimension: ytdrelease_actual {
    type: number
    sql: ${TABLE}.YTDReleaseActual ;;
  }

  dimension: ytdrelease_target {
    type: number
    sql: ${TABLE}.YTDReleaseTarget ;;
  }

  dimension: open_reqs_actual {
    type: number
    sql: ${TABLE}.OpenReqsActual ;;
  }

  dimension: open_reqs_target {
    type: number
    sql: ${TABLE}.OpenReqsTarget ;;
  }

  dimension: commentary {
    type: string
    html: <font size="10">{{ value }}</font> ;;
    sql: ${TABLE}.Commentary ;;

  }

  dimension_group: week_ending_date {
    type: time
    sql: ${TABLE}.WeekEndingDate ;;
  }

  set: detail {
    fields: [
      asset_function,
      schedule_adherence_actual,
      schedule_adherence_target,
      ytdrelease_actual,
      ytdrelease_target,
      open_reqs_actual,
      open_reqs_target,
      week_ending_date_time
    ]
  }

  measure: avg_adherence_target {
    type:  average
    sql: ${schedule_adherence_target} / 100 ;;
    value_format_name: percent_0
  }

  measure: avg_adherence_actual {
    type: average
    sql: ${schedule_adherence_actual} / 100;;
    value_format_name: percent_0
  }

  measure: sum_ytd_release_actual {
    type: sum
    sql: ${ytdrelease_actual} ;;
  }

  measure: sum_ytd_release_target {
    type: sum
    sql: ${ytdrelease_target} ;;
  }

  measure: sum_open_reqs_actual {
    type: sum
    sql: ${open_reqs_actual} ;;
  }

  measure: sum_open_reqs_target {
    type: sum
    sql: ${open_reqs_target} ;;
  }

  measure: target_delivery {
    type: sum
    sql: Case When (${ytdrelease_target}-${ytdrelease_actual})<0
         then 0
         else ${ytdrelease_target}-${ytdrelease_actual} end;;
  }


}
