view: sltweekly_data_entry_excel_qc{
  derived_table: {
    sql: SELECT [WeekEndingDate]
      ,[AssetFunction]
      ,[ScheduleAdherenceActual]
      ,[ScheduleAdherenceTarget]
      ,[ReleaseTestingActual]
      ,[ReleaseTestingTarget]
      ,[StabilityTestingActual]
      ,[StabilityTestingTarget]
      ,[OTIFDeliverablesActual]
      ,[OTIFDeliverablesTarget]
      ,[RawMaterialsTestingActual]
      ,[RawMaterialsTestingTarget]
      ,[OpenReqsActual]
      ,[OpenReqsTarget]
      ,[ActiveFTEActual]
      ,[ActiveFTETarget]
      ,[Commentary]
      ,[LoadDate]
      ,[LoadID]
      ,[RecordSource]
  FROM [dataLake].[SLTWeeklyDataEntry_Excel_QC]
  where LoadID = (
  select max(LoadID) maxLoadID
  from datalake.SLTWeeklyDataEntry_Excel_QC
  )
 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension_group: week_ending_date {
    type: time
    sql: ${TABLE}.WeekEndingDate ;;
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

  dimension: release_testing_actual {
    type: number
    sql: ${TABLE}.ReleaseTestingActual ;;
  }

  dimension: release_testing_target {
    type: number
    sql: ${TABLE}.ReleaseTestingTarget ;;
  }

  dimension: stability_testing_actual {
    type: number
    sql: ${TABLE}.StabilityTestingActual ;;
  }

  dimension: stability_testing_target {
    type: number
    sql: ${TABLE}.StabilityTestingTarget ;;
  }

  dimension: otifdeliverables_actual {
    type: number
    sql: ${TABLE}.OTIFDeliverablesActual ;;
  }

  dimension: otifdeliverables_target {
    type: number
    sql: ${TABLE}.OTIFDeliverablesTarget ;;
  }

  dimension: raw_materials_testing_actual {
    type: number
    sql: ${TABLE}.RawMaterialsTestingActual ;;
  }

  dimension: raw_materials_testing_target {
    type: number
    sql: ${TABLE}.RawMaterialsTestingTarget ;;
  }

  dimension: open_reqs_actual {
    type: number
    sql: ${TABLE}.OpenReqsActual ;;
  }

  dimension: open_reqs_target {
    type: number
    sql: ${TABLE}.OpenReqsTarget ;;
  }

  dimension: active_fteactual {
    type: number
    sql: ${TABLE}.ActiveFTEActual ;;
  }

  dimension: active_ftetarget {
    type: number
    sql: ${TABLE}.ActiveFTETarget ;;
  }

  dimension: commentary {
    type: string
    sql: ${TABLE}.Commentary ;;
  }

  dimension_group: load_date {
    type: time
    sql: ${TABLE}.LoadDate ;;
  }

  dimension: load_id {
    type: number
    sql: ${TABLE}.LoadID ;;
  }

  dimension: record_source {
    type: string
    sql: ${TABLE}.RecordSource ;;
  }

  measure: release_testing_pct {
    type: average
    sql: case when ${release_testing_target} = 0 then 1 else ${release_testing_actual}/${release_testing_target} end;;
    value_format_name: percent_0
  }

  measure: stability_testing_pct {
    type: average
    sql: case when ${stability_testing_target} = 0 then 1 else ${stability_testing_actual}/${stability_testing_target} end;;
    value_format_name: percent_0
  }

  measure: raw_materials_testing_pct {
    type: average
    sql: case when ${raw_materials_testing_target} = 0 then 1 else ${raw_materials_testing_actual}/${raw_materials_testing_target} end;;
    value_format_name: percent_0
  }


  set: detail {
    fields: [
      week_ending_date_time,
      asset_function,
      schedule_adherence_actual,
      schedule_adherence_target,
      release_testing_actual,
      release_testing_target,
      stability_testing_actual,
      stability_testing_target,
      otifdeliverables_actual,
      otifdeliverables_target,
      raw_materials_testing_actual,
      raw_materials_testing_target,
      open_reqs_actual,
      open_reqs_target,
      active_fteactual,
      active_ftetarget,
      commentary,
      load_date_time,
      load_id,
      record_source
    ]
  }
}
