view: qc_testing_union {
  derived_table: {
    sql:
      select WeekEndingDate
        , AssetFunction
        , 'Release Testing' as TestType
        , ReleaseTestingActual as Actual
        , ReleaseTestingTarget as Target
      from datalake.SLTWeeklyDataEntry_Excel_QC
      where LoadID = (select max(LoadID) from datalake.SLTWeeklyDataEntry_Excel_QC)

      UNION ALL

      select WeekEndingDate
        , AssetFunction
        , 'Stability Testing' as TestType
        , StabilityTestingActual as Actual
        , StabilityTestingTarget as Target
      from datalake.SLTWeeklyDataEntry_Excel_QC
      where LoadID = (select max(LoadID) from datalake.SLTWeeklyDataEntry_Excel_QC)

      UNION ALL

      select WeekEndingDate
        , AssetFunction
        , 'Raw Materials Testing' as TestType
        , RawMaterialsTestingActual as Actual
        , RawMaterialsTestingTarget as Target
      from datalake.SLTWeeklyDataEntry_Excel_QC
      where LoadID = (select max(LoadID) from datalake.SLTWeeklyDataEntry_Excel_QC)

    UNION ALL

      select WeekEndingDate
        , AssetFunction
        , 'S&OP OTIF' as TestType
        , OTIFDeliverablesActual as Actual
        , OTIFDeliverablesTarget as Target
      from datalake.SLTWeeklyDataEntry_Excel_QC
      where LoadID = (select max(LoadID) from datalake.SLTWeeklyDataEntry_Excel_QC)
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

  dimension: test_type {
    type: string
    sql: ${TABLE}.TestType ;;
  }

  dimension: actual {
    type: number
    sql: ${TABLE}.Actual ;;
  }

  dimension: target {
    type: number
    sql: ${TABLE}.Target ;;
  }

  measure: sum_actual {
    type: sum
    sql: ${TABLE}.Actual ;;
  }

  measure: sum_target {
    type: sum
    sql: ${TABLE}.Target ;;
  }

  measure: testing_pct {
    type: average
    sql: case when ${target} = 0 then 1 else ${actual}/${target} end;;
    value_format_name: percent_0
  }

  set: detail {
    fields: [week_ending_date_time, asset_function, test_type, actual, target]
  }
}
