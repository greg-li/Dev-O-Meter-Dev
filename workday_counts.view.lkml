view: workday_counts {
  derived_table: {
    sql: select ccm.assetMapping
      , ccm.assetName
      , ccm.area
      , ccm.costCenterCategory
      , ccm.costCenter
      , ccm.costCenterDescription
      , wc.head_count as headCount
      , wc.open_positions as openPositions
      , 0 as openReqsTarget
      , wc.open_reqs as openReqs
      , wc.LoadDate
      , maxLoadDate = (
        select max(LoadDate)
        from datalake.WorkdayCounts
      )
    from datalake.CostCenterMapping ccm
    inner join datalake.WorkdayCounts wc
    on ccm.costCenter = wc.cost_center_id

    union all

    select am.Master
      , ''
      , ''
      , ''
      , ''
      , am.Master + ' Reqs Target'
      , 0
      , 0
      , OpenReqsTarget
      , 0
      , WeekEndingDate
      , maxLoadDate = (
        select max(WeekEndingDate)
        from dataLake.SLTWeeklyDataEntry_Excel_Mfg
      )
    from datalake.SLTWeeklyDataEntry_Excel_Mfg mfg
    inner join (
      select Excel
        , Master
      from datalake.AssetMapping_Excel
      where LoadID = (select max(LoadID) from datalake.AssetMapping_Excel)
    ) am
    on mfg.AssetFunction = am.Excel
    where mfg.LoadID = (select max(LoadID) from datalake.SLTWeeklyDataEntry_Excel_Mfg)
    and mfg.WeekEndingDate >= '06/05/2019'

  union all

    select am.Master
      , ''
      , ''
      , ''
      , ''
      , am.Master + ' Reqs Target'
      , 0
      , 0
      , OpenReqsTarget
      , 0
      , MonthEndingDate
      , maxLoadDate = (
        select max(MonthEndingDate)
        from dataLake.SLTWeeklyDataEntry_Excel_MSAT
        where month(MonthEndingDate) = month(GETDATE())
      )
    from datalake.SLTWeeklyDataEntry_Excel_MSAT mfg
    inner join (
      select Excel
        , Master
      from datalake.AssetMapping_Excel
      where LoadID = (select max(LoadID) from datalake.AssetMapping_Excel)
    ) am
    on mfg.AssetFunction = am.Excel
    where mfg.LoadID = (select max(LoadID) from datalake.SLTWeeklyDataEntry_Excel_MSAT)
    and mfg.MonthEndingDate >= '06/05/2019'

  union all

    select am.Master
      , ''
      , ''
      , ''
      , ''
      , am.Master + ' Reqs Target'
      , 0
      , 0
      , OpenReqsTarget
      , 0
      , WeekEndingDate
      , maxLoadDate = (
        select max(WeekEndingDate)
        from dataLake.SLTWeeklyDataEntry_Excel_PPL
      )
    from datalake.SLTWeeklyDataEntry_Excel_PPL mfg
    inner join (
      select Excel
        , Master
      from datalake.AssetMapping_Excel
      where LoadID = (select max(LoadID) from datalake.AssetMapping_Excel)
    ) am
    on mfg.AssetFunction = am.Excel
    where mfg.LoadID = (select max(LoadID) from datalake.SLTWeeklyDataEntry_Excel_PPL)
    and mfg.WeekEndingDate >= '06/05/2019'

  union all

  select am.Master
      , ''
      , ''
      , ''
      , ''
      , am.Master + ' Reqs Target'
      , 0
      , 0
      , OpenReqsTarget
      , 0
      , WeekEndingDate
      , maxLoadDate = (
        select max(WeekEndingDate)
        from dataLake.SLTWeeklyDataEntry_Excel_QC
      )
    from datalake.SLTWeeklyDataEntry_Excel_QC mfg
    inner join (
      select Excel
        , Master
      from datalake.AssetMapping_Excel
      where LoadID = (select max(LoadID) from datalake.AssetMapping_Excel)
    ) am
    on mfg.AssetFunction = am.Excel
    where mfg.LoadID = (select max(LoadID) from datalake.SLTWeeklyDataEntry_Excel_QC)
    and mfg.WeekEndingDate >= '06/05/2019'

  union all

    select AssetFunction
      , ''
      , ''
      , ''
      , ''
      , ''
      , 0
    , 0
    , OpenReqsTarget
      , OpenReqsActual
      , WeekEndingDate
      , maxLoadDate = (
        select max(WeekEndingDate)
        from datalake.SLTWeeklyDataEntry_Excel_Mfg
      )
    from datalake.SLTWeeklyDataEntry_Excel_Mfg
    where WeekEndingDate < '06/05/2019'
    and LoadID = (select max(LoadID) from datalake.SLTWeeklyDataEntry_Excel_Mfg)

  union all

    select AssetFunction
      , ''
      , ''
      , ''
      , ''
      , ''
      , 0
    , 0
    , OpenReqsTarget
      , OpenReqsActual
      , MonthEndingDate
      , maxLoadDate = (
        select max(MonthEndingDate)
      from dataLake.SLTWeeklyDataEntry_Excel_MSAT
      where month(MonthEndingDate) = month(GETDATE())
      )
    from datalake.SLTWeeklyDataEntry_Excel_MSAT
  where MonthEndingDate < '06/05/2019'
  and LoadID = (select max(LoadID) from datalake.SLTWeeklyDataEntry_Excel_MSAT)

  union all

    select AssetFunction
      , ''
      , ''
      , ''
      , ''
      , ''
      , 0
    , 0
    , OpenReqsTarget
      , OpenReqsActual
      , WeekEndingDate
      , maxLoadDate = (
        select max(WeekEndingDate)
        from datalake.SLTWeeklyDataEntry_Excel_PPL
      )
    from datalake.SLTWeeklyDataEntry_Excel_PPL
    where WeekEndingDate < '06/05/2019'
  and LoadID = (select max(LoadID) from datalake.SLTWeeklyDataEntry_Excel_PPL)

  union all

  select AssetFunction
      , ''
      , ''
      , ''
      , ''
      , ''
      , 0
    , 0
    , OpenReqsTarget
      , OpenReqsActual
      , WeekEndingDate
      , maxLoadDate = (
        select max(WeekEndingDate)
        from datalake.SLTWeeklyDataEntry_Excel_QC
      )
    from datalake.SLTWeeklyDataEntry_Excel_QC
    where WeekEndingDate < '06/05/2019'
  and LoadID = (select max(LoadID) from datalake.SLTWeeklyDataEntry_Excel_QC) ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: asset_mapping {
    type: string
    sql: ${TABLE}.assetMapping ;;
  }

  dimension: asset_name {
    type: string
    sql: ${TABLE}.assetName ;;
  }

  dimension: area {
    type: string
    sql: ${TABLE}.area ;;
  }

  dimension: cost_center_category {
    type: string
    sql: ${TABLE}.costCenterCategory ;;
  }

  dimension: cost_center {
    type: string
    sql: ${TABLE}.costCenter ;;
  }

  dimension: cost_center_description {
    type: string
    sql: ${TABLE}.costCenterDescription ;;
  }

  dimension: head_count {
    type: number
    sql: ${TABLE}.headCount ;;
  }

  dimension: open_positions {
    type: number
    sql: ${TABLE}.openPositions ;;
  }

  dimension: open_reqs {
    type: number
    sql: ${TABLE}.openReqs ;;
  }

  dimension: open_reqs_target {
    type: number
    sql: ${TABLE}.openReqsTarget ;;
  }

  dimension_group: load_date {
    type: time
    sql: ${TABLE}.LoadDate ;;
  }

  dimension_group: max_load_date {
    type: time
    sql: ${TABLE}.maxLoadDate ;;
  }

  measure: total_head_count {
    type: sum
    sql: ${head_count} ;;
  }

  measure: total_open_reqs {
    type: sum
    sql: ${open_reqs} ;;
  }

  measure: total_open_positions {
    type: sum
    sql: ${open_positions} ;;
  }

  measure: total_open_reqs_target {
    type: sum
    sql: ${open_reqs_target} ;;
  }


  set: detail {
    fields: [
      asset_mapping,
      asset_name,
      area,
      cost_center_category,
      cost_center,
      cost_center_description,
      head_count,
      open_positions,
      open_reqs,
      load_date_time
    ]
  }
}
