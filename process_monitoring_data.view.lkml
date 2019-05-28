view: process_monitoring_data {
  derived_table: {
    sql: select
'USPO-10605' as RecordNum
,a.SampleID as SampleID
,a.Sample_Date_Time as SampleDateTime
,0 as DayNumber
,a.Culture_Initiated_Date_Time as CultureInitiatedDateTime
,(Cast(Cast(b.Sample_Date_Time as datetime)- cast(a.Culture_Initiated_Date_Time as datetime) as float)*24) as CultureDurationAge
,a.[Seeding_Concentration] as SeedingConcentration
,a.approvestatus as ApproveStatus
,a.product_name as ProductName
,a.batch_number as BatchNumber
,Right(a.batch_number,Len(a.batch_number) - 3) as MasterBatchNumber
,a.cell_bank_id as CellBankID
,a.ampoule_id as Ampoule_ID
,a.piecenumber as PieceNumber
,a.Viability____ as ViabilityPct
,a.Viable_Cell_Concentration as ViableCellConcentration
,a.generation_number as GenerationNumber
,a.Final_Volume__mL_ as FinalVolumemL
,a.Inoculum_Room_Number as InocRoomNumber
,a.Media_Use_By_Date as MediaUseByDate
,a.Thaw_Start_Date_Time as ThawStartDateTime
,a.Thaw_End_Date_Time as ThawEndDateTime
,a.Vessel_Size as VesselSize
,a.Incubator_ID as IncubatorID
,null as BatchRecordID_Sending
,null as BatchNumberID_Sending
,Case when a.piecenumber > 1 then 1 else 0 end as SuspectDataFlag
,(Log(a.Viable_Cell_Concentration)-Log(a.[Seeding_Concentration]))/(Cast(Cast(b.Sample_Date_Time as datetime)- cast(a.Culture_Initiated_Date_Time as datetime) as float)*24) as GrowthRate
,Log(2)/((Log(a.Viable_Cell_Concentration)-Log(a.[Seeding_Concentration]))/(Cast(Cast(b.Sample_Date_Time as datetime)- cast(a.Culture_Initiated_Date_Time as datetime) as float)*24)) as DoublingTime
from [dataLake].[USPO_10605] a
left join [dataLake].[USPO_10606] b
on (a.[Batch_Number] = b.[Batch_Number] and a.[PieceNumber] = b.[PieceNumber])

union all

select
'USPO-10606' as RecordNum
,a.SampleID as SampleID
,a.Sample_Date_Time as SampleDateTime
,Day_Number as DayNumber
,a.Culture_Initiated_Date_Time_ as CultureInitiatedDateTime
,a.[Culture_Duration__Hours_] as CultureDurationAge
,a.[Seeding_Concentration] as SeedingConcentration
,a.approvestatus as ApproveStatus
,a.product_name as ProductName
,a.batch_number as BatchNumber
,Right(a.batch_number,Len(a.batch_number) - 3) as MasterBatchNumber
,null as CellBankID
,null as Ampoule_ID
,a.piecenumber as PieceNumber
,a.Viability____ as ViabilityPct
,a.Viable_Cell_Concentration as ViableCellConcentration
,a.generation_number as GenerationNumber
,a.Final_Volume__mL_ as FinalVolumemL
,a.Inoculum_Room_Number as InocRoomNumber
,a.Media_Use_By_Date as MediaUseByDate
,null as ThawStartDateTime
,null as ThawEndDateTime
,a.Vessel_Size as VesselSize
,a.Incubator_ID as IncubatorID
,a.Batch_Record_ID__sending_ as BatchRecordID_Sending
,a.Batch_Number__sending_ as BatchNumberID_Sending
,Case when a.piecenumber > 1 then 1 else 0 end as SuspectDataFlag
,(Log(a.Viable_Cell_Concentration)-Log(a.[Seeding_Concentration]))/cast((case when isnumeric(a.[Culture_Duration__Hours_])=1 then a.[Culture_Duration__Hours_] else null end) as float)  as GrowthRate
,Log(2)/NullIf(((Log(a.Viable_Cell_Concentration)-Log(a.[Seeding_Concentration]))/cast((case when isnumeric(a.[Culture_Duration__Hours_])=1 then a.[Culture_Duration__Hours_] else null end) as float)),0) as DoublingTime
from [dataLake].[USPO_10606] a

union all

select
'USPO-10607' as RecordNum
,a.SampleID as SampleID
,a.Sample_Date_Time as SampleDateTime
,Day_Number as DayNumber
,a.Culture_Initiated_Date_Time_ as CultureInitiatedDateTime
,a.[Culture_Duration__Hours_] as CultureDurationAge
,a.[Seeding_Concentration] as SeedingConcentration
,a.approvestatus as ApproveStatus
,a.product_name as ProductName
,a.batch_number as BatchNumber
,Right(a.batch_number,Len(a.batch_number) - 3) as MasterBatchNumber
,null as CellBankID
,null as Ampoule_ID
,a.piecenumber as PieceNumber
,a.Viability____ as ViabilityPct
,a.Viable_Cell_Concentration as ViableCellConcentration
,a.generation_number as GenerationNumber
,a.Final_Volume__mL_ as FinalVolumemL
,a.Inoculum_Room_Number as InocRoomNumber
,a.Media_Use_By_Date as MediaUseByDate
,null as ThawStartDateTime
,null as ThawEndDateTime
,a.Vessel_Size as VesselSize
,a.Incubator_ID as IncubatorID
,a.Batch_Record_ID__sending_ as BatchRecordID_Sending
,a.Batch_Number__sending_ as BatchNumberID_Sending
,0 as SuspectDataFlag
,(Log(a.Viable_Cell_Concentration)-Log(a.[Seeding_Concentration]))/cast((case when isnumeric(a.[Culture_Duration__Hours_])=1 then a.[Culture_Duration__Hours_] else null end) as float)  as GrowthRate
,Log(2)/NullIf(((Log(a.Viable_Cell_Concentration)-Log(a.[Seeding_Concentration]))/cast((case when isnumeric(a.[Culture_Duration__Hours_])=1 then a.[Culture_Duration__Hours_] else null end) as float)),0) as DoublingTime
from [dataLake].[USPO_10607] a

union all

select
'USPO-10608' as RecordNum
,a.SampleID as SampleID
,a.Sample_Date_Time as SampleDateTime
,Day_Number as DayNumber
,a.Culture_Initiated_Date_Time as CultureInitiatedDateTime
,a.[Culture_Duration__Hours_] as CultureDurationAge
,a.[Seeding_Concentration] as SeedingConcentration
,a.approvestatus as ApproveStatus
,a.product_name as ProductName
,a.batch_number as BatchNumber
,Right(a.batch_number,Len(a.batch_number) - 3) as MasterBatchNumber
,null as CellBankID
,null as Ampoule_ID
,a.piecenumber as PieceNumber
,a.Viability____ as ViabilityPct
,a.Viable_Cell_Concentration as ViableCellConcentration
,a.generation_number as GenerationNumber
,[Post_Inoculation_Weight__Kg_]*1000 as FinalVolumemL
,a.Inoculum_Room_Number as InocRoomNumber
,a.Media_Use_By_Date as MediaUseByDate
,null as ThawStartDateTime
,null as ThawEndDateTime
,'20L' as VesselSize
,null as IncubatorID
,a.Batch_Record_ID__sending_ as BatchRecordID_Sending
,a.Batch_Number__sending_ as BatchNumberID_Sending
,0 as SuspectDataFlag
,(Log(a.Viable_Cell_Concentration)-Log(a.[Seeding_Concentration]))/cast((case when isnumeric(a.[Culture_Duration__Hours_])=1 then a.[Culture_Duration__Hours_] else null end) as float)  as GrowthRate
,Log(2)/NullIf(((Log(a.Viable_Cell_Concentration)-Log(a.[Seeding_Concentration]))/cast((case when isnumeric(a.[Culture_Duration__Hours_])=1 then a.[Culture_Duration__Hours_] else null end) as float)),0) as DoublingTime
from [dataLake].[USPO_10608] a

union all

select
'USPO-10609' as RecordNum
,a.SampleID as SampleID
,a.Sample_Date_Time as SampleDateTime
,Day_Number as DayNumber
,a.Culture_Initiated_Date_Time as CultureInitiatedDateTime
,a.[Culture_Duration__Hours_] as CultureDurationAge
,a.[Seeding_Concentration] as SeedingConcentration
,a.approvestatus as ApproveStatus
,a.product_name as ProductName
,a.batch_number as BatchNumber
,Right(a.batch_number,Len(a.batch_number) - 3) as MasterBatchNumber
,null as CellBankID
,null as Ampoule_ID
,a.piecenumber as PieceNumber
,a.Viability____ as ViabilityPct
,a.Viable_Cell_Concentration as ViableCellConcentration
,a.generation_number as GenerationNumber
,a.[Total_Fill_Weight__Kg_] *1000 as FinalVolumemL
--,cast(isnull(case when [Total_Fill_Weight__Kg_]='NULL' then null else [Total_Fill_Weight__Kg_] end,0)as float) *1000 as FinalVolumemL
,null as InocRoomNumber
,a.Media_Use_By_Date as MediaUseByDate
,null as ThawStartDateTime
,null as ThawEndDateTime
,'20L' as VesselSize
,null as IncubatorID
,a.Batch_Record_ID__sending_ as BatchRecordID_Sending
,a.Batch_Number__sending_ as BatchNumberID_Sending
,0 as SuspectDataFlag
,(Log(a.Viable_Cell_Concentration)-Log(a.[Seeding_Concentration]))/cast((case when isnumeric(a.[Culture_Duration__Hours_])=1 then a.[Culture_Duration__Hours_] else null end) as float)  as GrowthRate
,Log(2)/NullIf(((Log(a.Viable_Cell_Concentration)-Log(a.[Seeding_Concentration]))/cast((case when isnumeric(a.[Culture_Duration__Hours_])=1 then a.[Culture_Duration__Hours_] else null end) as float)),0) as DoublingTime
from [dataLake].[USPO_10609] a

union all

select
'USPO-10610' as RecordNum
,a.SampleID as SampleID
,a.Sample_Date_Time as SampleDateTime
,Day_Number as DayNumber
,null as CultureInitiatedDateTime
,cast((case when isnumeric(a.[Culture_Duration_Age])=1 then a.[Culture_Duration_Age] else 0 end) as float) as CultureDurationAge
,a.[Seeding_Concentration] as SeedingConcentration
,a.approvestatus as ApproveStatus
,a.product_name as ProductName
,a.batch_number as BatchNumber
,Right(a.batch_number,Len(a.batch_number) - 3) as MasterBatchNumber
,null as CellBankID
,null as Ampoule_ID
,a.piecenumber as PieceNumber
,a.Viability____ as ViabilityPct
,a.Viable_Cell_Concentration as ViableCellConcentration
,a.generation_number as GenerationNumber
,a.[Inoculum_Weight__kg_] *1000 as FinalVolumemL
,null as InocRoomNumber
,null as MediaUseByDate
,null as ThawStartDateTime
,null as ThawEndDateTime
,'20L' as VesselSize
,null as IncubatorID
,a.Batch_Record_ID__sending_ as BatchRecordID_Sending
,a.Batch_Number__sending_ as BatchNumberID_Sending
,0 as SuspectDataFlag
,(Log(a.Viable_Cell_Concentration)-Log(a.[Seeding_Concentration]))/cast((case when isnumeric(a.[Culture_Duration_Age])=1 then a.[Culture_Duration_Age] else null end) as float)  as GrowthRate
,Log(2)/NullIf(((Log(a.Viable_Cell_Concentration)-Log(a.[Seeding_Concentration]))/cast((case when isnumeric(a.[Culture_Duration_Age])=1 then a.[Culture_Duration_Age] else null end) as float)),0) as DoublingTime
from [dataLake].[USPO_10610] a


       ;;
  }


  parameter: dimension_selector{
    type: string
    description: "This fields allow for dynamic dimension selection. It must be used in conjunction with the Reporting Dimension."
    allowed_value: {
      label: "By Batch"
      value: "batch"
    }
    allowed_value: {
      label: "By Master Batch"
      value: "masterbatch"
    }
    allowed_value: {
      label: "By Vessel"
      value: "vessel"
    }
    allowed_value: {
      label: "Yearly"
      value: "yearly"
    }
    allowed_value: {
      label: "Quarterly"
      value: "quarterly"
    }
    allowed_value: {
      label: "Monthly"
      value: "monthly"
    }
    allowed_value: {
      label: "Weekly"
      value: "weekly"
    }
  }

  dimension: dimension_selector_helper {
    type: string
    hidden: yes
    sql:
    {% if dimension_selector._parameter_value == "'batch'"%}
    ${batch_number}
    {% elsif dimension_selector._parameter_value == "'masterbatch'"%}
    ${master_batch_number}
    {% elsif dimension_selector._parameter_value == "'vessel'"%}
    ${vessel_size}
    {% elsif dimension_selector._parameter_value == "'yearly'"%}
    ${sample_date_time_year}
    {% elsif dimension_selector._parameter_value == "'quarterly'"%}
    ${sample_date_time_quarter_of_year}
    {% elsif dimension_selector._parameter_value == "'monthly'"%}
    ${sample_date_time_month}
    {% elsif dimension_selector._parameter_value == "'weekly'"%}
    ${sample_date_time_week}
    {% else %}
    ${batch_number}
    {% endif %}
;;
  }


  dimension: dim_value_selector {
    label: "Reporting Period"
    description: "This field needs to be used in conjunction with the dimension_selector Filter. This field allows the graphs to plot over a dynamic dimension selection"
    type: string
    sql:${dimension_selector_helper}
    ;;
  }


  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: growth_rate_value {
    type: average
    sql: ${TABLE}.GrowthRate ;;
  }

  measure: doubling_time_value {
    type: average
    sql: ${TABLE}.DoublingTime ;;
  }

  measure: growth_rate_mean {
    label: "Mean Growth Rate"
    type:  average
    sql: ${TABLE}.GrowthRate ;;
  }


  measure: growth_rate_min {
    label: "Min. Growth Rate"
    type:  min
    sql: ${TABLE}.GrowthRate ;;
  }


  measure: growth_rate_max {
    label: "Max Growth Rate"
    type:  max
    sql: ${TABLE}.GrowthRate ;;
  }


  measure: doublingtime_mean {
    label: "Mean Doubling Time"
    type:  average
    sql: ${TABLE}.DoublingTime ;;
  }


  measure: doublingtime_min {
    label: "Min. Doubling Time"
    type:  min
    sql: ${TABLE}.DoublingTime ;;
  }


  measure: doublingtime_max {
    label: "Max Doubling Time"
    type:  max
    sql: ${TABLE}.DoublingTime ;;
  }

  measure: viability_pct_value {
    label: "Avg. Viability Pct"
    type: average
    sql: ${TABLE}.ViabilityPct ;;
  }

  measure: viable_cell_concentration_value {
    label: "Avg. VCC"
    type: average
    sql: ${TABLE}.ViableCellConcentration ;;
  }

  dimension: record_num {
    type: string
    sql: ${TABLE}.RecordNum ;;
  }

  dimension: daynumber {
    type: number
    sql: ${TABLE}.DayNumber ;;
  }
  dimension: sample_id {
    type: number
    sql: ${TABLE}.SampleID ;;
  }

  dimension_group: sample_date_time {
    label: "Sample Date-Time"
    type: time
    timeframes: [date,hour_of_day,week,week_of_year,day_of_week,day_of_month,month_name, month,quarter,quarter_of_year,year]
    sql: ${TABLE}.SampleDateTime ;;
  }

  dimension: culture_initiated_date_time {
    type: string
    sql: ${TABLE}.CultureInitiatedDateTime ;;
  }

  dimension: culture_duration_age {
    type: number
    sql: ${TABLE}.CultureDurationAge ;;
  }

  dimension: seeding_concentration {
    type: number
    sql: ${TABLE}.SeedingConcentration ;;
  }

  dimension: approve_status {
    type: number
    sql: ${TABLE}.ApproveStatus ;;
  }

  dimension: product_name {
    type: string
    sql: ${TABLE}.ProductName ;;
  }

  dimension: batch_number {
    type: string
    sql: ${TABLE}.BatchNumber ;;
  }

  dimension: master_batch_number {
    type: string
    sql: ${TABLE}.MasterBatchNumber ;;
  }

  dimension: cell_bank_id {
    type: string
    sql: ${TABLE}.CellBankID ;;
  }

  dimension: ampoule_id {
    type: string
    sql: ${TABLE}.Ampoule_ID ;;
  }

  dimension: piece_number {
    type: number
    sql: ${TABLE}.PieceNumber ;;
  }



  dimension: viability_pct {
    type: number
    sql: ${TABLE}.ViabilityPct ;;
  }

  dimension: viable_cell_concentration {
    type: number
    sql: ${TABLE}.ViableCellConcentration ;;
  }

  dimension: generation_number {
    type: number
    sql: ${TABLE}.GenerationNumber ;;
  }

  dimension: final_volumem_l {
    type: number
    sql: ${TABLE}.FinalVolumemL ;;
  }

  dimension: inoc_room_number {
    type: string
    sql: ${TABLE}.InocRoomNumber ;;
  }

  dimension: media_use_by_date {
    type: string
    sql: ${TABLE}.MediaUseByDate ;;
  }

  dimension: thaw_start_date_time {
    type: string
    sql: ${TABLE}.ThawStartDateTime ;;
  }

  dimension: thaw_end_date_time {
    type: string
    sql: ${TABLE}.ThawEndDateTime ;;
  }

  dimension: vessel_size {
    type: string
    sql: ${TABLE}.VesselSize ;;
  }

  dimension: incubator_id {
    type: string
    sql: ${TABLE}.IncubatorID ;;
  }

  dimension: batch_record_id_sending {
    type: string
    sql: ${TABLE}.BatchRecordID_Sending ;;
  }

  dimension: batch_number_id_sending {
    type: string
    sql: ${TABLE}.BatchNumberID_Sending ;;
  }

  dimension: suspect_data_flag {
    type: number
    sql: ${TABLE}.SuspectDataFlag ;;
  }

  dimension: growth_rate {
    type: number
    sql: ${TABLE}.GrowthRate ;;
  }

  dimension: doubling_time {
    type: number
    sql: ${TABLE}.DoublingTime ;;
  }

  set: detail {
    fields: [
      record_num,
      sample_id,
      sample_date_time_date,
      daynumber,
      culture_initiated_date_time,
      culture_duration_age,
      seeding_concentration,
      approve_status,
      product_name,
      batch_number,
      master_batch_number,
      cell_bank_id,
      ampoule_id,
      piece_number,
      viability_pct,
      viable_cell_concentration,
      generation_number,
      final_volumem_l,
      inoc_room_number,
      media_use_by_date,
      thaw_start_date_time,
      thaw_end_date_time,
      vessel_size,
      incubator_id,
      batch_record_id_sending,
      batch_number_id_sending,
      suspect_data_flag,
      growth_rate,
      doubling_time
    ]
  }
}
