view: process_monitoring_data {
  derived_table: {
    sql:
select
RecordNum
,SampleID
,SampleDateTime
,DayNumber
,CultureInitiatedDateTime
,CultureDurationAge
,SeedingConcentration
,ApproveStatus
,ProductName
,BatchNumber
,MasterBatchNumber
,CellBankID
,Ampoule_ID
,PieceNumber
,ViabilityPct
,ViableCellConcentration
,GenerationNumber
,FinalVolumemL
,InocRoomNumber
,MediaUseByDate
,ThawStartDateTime
,ThawEndDateTime
,VesselSize
,IncubatorID
,BatchRecordID_Sending
,BatchNumberID_Sending
,SuspectDataFlag
,GrowthRate
,DoublingTime
,VCC_TargetMin
,VCC_TargetMean
,VCC_TargetMax
,Viability_TargetMin
,Viability_TargetMean
,Viability_TargetMax
,Duration_TargetMin
,Duration_TargetMean
,Duration_TargetMax
,GrowthRate_TargetMin
,GrowthRate_TargetMean
,GrowthRate_TargetMax
,DoublingTime_TargetMin
,DoublingTime_TargetMean
,DoublingTime_TargetMax
from

(
/*
--------------------------------
START of USPO-10605 Records
--------------------------------
*/
select
'USPO-10605' as RecordNum
,a.SampleID as SampleID
,a.Sample_Date_Time as SampleDateTime
,0 as DayNumber
,a.Culture_Initiated_Date_Time as CultureInitiatedDateTime
,Cast(DateDiff(minute,Cast(a.Culture_Initiated_Date_Time as datetime),cast(b.Sample_Date_Time as datetime))/60 as float) as CultureDurationAge
,a.[Seeding_Concentration] as SeedingConcentration
,a.approvestatus as ApproveStatus
,a.product_name as ProductName
,a.batch_number as BatchNumber
,Right(a.batch_number,Len(a.batch_number) - 3) as MasterBatchNumber
,a.cell_bank_id as CellBankID
,a.ampoule_id as Ampoule_ID
,a.piecenumber as PieceNumber
,b.Viability____ as ViabilityPct
,b.Viable_Cell_Concentration as ViableCellConcentration
--,a.Viable_Cell_Concentration as ViableCellConcentration
,a.generation_number as GenerationNumber
,a.Final_Volume__mL_ as FinalVolumemL
,a.Inoculum_Room_Number as InocRoomNumber
,a.Media_Use_By_Date as MediaUseByDate
,a.Thaw_Start_Date_Time as ThawStartDateTime
,a.Thaw_End_Date_Time as ThawEndDateTime
,'Step 1 - ' + a.Vessel_Size as VesselSize
,a.Incubator_ID as IncubatorID
,null as BatchRecordID_Sending
,null as BatchNumberID_Sending
,Case when a.piecenumber > 1 then 1 else 0 end as SuspectDataFlag
,(Log(b.Viable_Cell_Concentration)-Log(a.[Seeding_Concentration]))/(Cast(Cast(b.Sample_Date_Time as datetime)- cast(a.Culture_Initiated_Date_Time as datetime) as float)*24) as GrowthRate
,Log(2)/((Log(b.Viable_Cell_Concentration)-Log(a.[Seeding_Concentration]))/(Cast(Cast(b.Sample_Date_Time as datetime)- cast(a.Culture_Initiated_Date_Time as datetime) as float)*24)) as DoublingTime
from [dataLake].[USPO_10605] a
left join [dataLake].[USPO_10606] b
on (a.[Batch_Number] = b.[Batch_Number] and a.[PieceNumber] = b.[PieceNumber])
--where a.Sample_Date_Time >= '2019-01-01'
/*
--------------------------------
END of USPO-10605 Records
--------------------------------
*/
union all
/*
--------------------------------
START of USPO-10606 Records
--------------------------------
*/
select
'USPO-10606' as RecordNum
,a.SampleID as SampleID
,b.Sample_Date_Time as SampleDateTime
,a.Day_Number as DayNumber
,a.Culture_Initiated_Date_Time_ as CultureInitiatedDateTime
,Cast(DateDiff(minute,a.Culture_Initiated_Date_Time_,b.Sample_Date_Time)/60 as float)as CultureDurationAge
--,a.[Culture_Duration__Hours_] as CultureDurationAge
,Case when a.[Seeding_Concentration] is null then 2.5 else a.[Seeding_Concentration] end as SeedingConcentration
,a.approvestatus as ApproveStatus
,a.product_name as ProductName
,a.batch_number as BatchNumber
,Right(a.batch_number,Len(a.batch_number) - 3) as MasterBatchNumber
,c.cell_bank_id as CellBankID
,c.ampoule_id as Ampoule_ID
,a.piecenumber as PieceNumber
,b.Viability____ as ViabilityPct
,b.Viable_Cell_Concentration as ViableCellConcentration
,a.generation_number as GenerationNumber
,a.Final_Volume__mL_ as FinalVolumemL
,a.Inoculum_Room_Number as InocRoomNumber
,a.Media_Use_By_Date as MediaUseByDate
,c.Thaw_Start_Date_Time as ThawStartDateTime
,c.Thaw_End_Date_Time as ThawEndDateTime
,'Step 2 - ' + a.Vessel_Size as VesselSize
,a.Incubator_ID as IncubatorID
,a.Batch_Record_ID__sending_ as BatchRecordID_Sending
,a.Batch_Number__sending_ as BatchNumberID_Sending
,Case when a.piecenumber > 1 then 1 else 0 end as SuspectDataFlag
,(Log(b.Viable_Cell_Concentration)-Log((Case when a.[Seeding_Concentration] is null then 2.5 else a.[Seeding_Concentration] end)))/cast((case when isnumeric(DateDiff(hh,a.Culture_Initiated_Date_Time_,b.Sample_Date_Time))=1 then Cast(DateDiff(minute,a.Culture_Initiated_Date_Time_,b.Sample_Date_Time)/60 as float)else null end) as float)  as GrowthRate
,Log(2)/NullIf(((Log(b.Viable_Cell_Concentration)-Log((Case when a.[Seeding_Concentration] is null then 2.5 else a.[Seeding_Concentration] end)))/cast((case when isnumeric(DateDiff(hh,a.Culture_Initiated_Date_Time_,b.Sample_Date_Time))=1 then Cast(DateDiff(minute,a.Culture_Initiated_Date_Time_,b.Sample_Date_Time)/60 as float)else null end) as float)),0) as DoublingTime
from [dataLake].[USPO_10606] a
left join [dataLake].[USPO_10607] b
on (a.[Batch_Number] = b.[Batch_Number] and a.[PieceNumber] = b.[PieceNumber])
left join [dataLake].[USPO_10605] c
on Right(a.batch_number,Len(a.batch_number) - 3) = Right(c.batch_number,Len(c.batch_number) - 3)
--where a.Sample_Date_Time >= '2019-01-01'
/*
--------------------------------
END of USPO-10606 Records
--------------------------------
*/
union all
/*
--------------------------------
START of USPO-10607_01 Records
--------------------------------
*/
select
'USPO-10607' as RecordNum
,a.SampleID as SampleID
,b.Sample_Date_Time as SampleDateTime
,a.Day_Number as DayNumber
,coalesce(a.Culture_Initiated_Date_Time_,aprev.Culture_Initiated_Date_Time_) as CultureInitiatedDateTime
,Cast(DateDiff(minute,coalesce(a.Culture_Initiated_Date_Time_,aprev.Culture_Initiated_Date_Time_),b.Sample_Date_Time)/60 as float) as CultureDurationAge
--,a.[Culture_Duration__Hours_] as CultureDurationAge
,coalesce(a.[Seeding_Concentration],aprev.[Seeding_Concentration]) as SeedingConcentration
,a.approvestatus as ApproveStatus
,a.product_name as ProductName
,a.batch_number as BatchNumber
,Right(a.batch_number,Len(a.batch_number) - 3) as MasterBatchNumber
,c.cell_bank_id as CellBankID
,c.ampoule_id as Ampoule_ID
,a.piecenumber as PieceNumber
,b.Viability____ as ViabilityPct
,b.Viable_Cell_Concentration as ViableCellConcentration
,a.generation_number as GenerationNumber
,a.Final_Volume__mL_ as FinalVolumemL
,coalesce(a.Inoculum_Room_Number,aprev.Inoculum_Room_Number) as InocRoomNumber
,coalesce(a.Media_Use_By_Date,aprev.Media_Use_By_Date)  as MediaUseByDate
,c.Thaw_Start_Date_Time as ThawStartDateTime
,c.Thaw_End_Date_Time as ThawEndDateTime
,case when a.Vessel_Size is null then 'Step 3 - 3L' else 'Step 3 - ' + a.Vessel_Size end as VesselSize
,coalesce(a.Incubator_ID,aprev.Incubator_ID) as IncubatorID
,coalesce(a.Batch_Record_ID__sending_,aprev.Batch_Record_ID__sending_) as BatchRecordID_Sending
,coalesce(a.Batch_Number__sending_,aprev.Batch_Number__sending_) as BatchNumberID_Sending
,0 as SuspectDataFlag
,(Log(b.Viable_Cell_Concentration)-Log(coalesce(a.[Seeding_Concentration],aprev.[Seeding_Concentration])))/cast((case when isnumeric(Cast(DateDiff(minute,coalesce(a.Culture_Initiated_Date_Time_,aprev.Culture_Initiated_Date_Time_),b.Sample_Date_Time)/60 as float))=1 then Cast(DateDiff(minute,coalesce(a.Culture_Initiated_Date_Time_,aprev.Culture_Initiated_Date_Time_),b.Sample_Date_Time)/60 as float) else null end) as float)  as GrowthRate
,Log(2)/NullIf(((Log(b.Viable_Cell_Concentration)-Log(coalesce(a.[Seeding_Concentration],aprev.[Seeding_Concentration])))/cast((case when isnumeric(Cast(DateDiff(minute,coalesce(a.Culture_Initiated_Date_Time_,aprev.Culture_Initiated_Date_Time_),b.Sample_Date_Time)/60 as float))=1 then Cast(DateDiff(minute,coalesce(a.Culture_Initiated_Date_Time_,aprev.Culture_Initiated_Date_Time_),b.Sample_Date_Time)/60 as float) else null end) as float)),0) as DoublingTime
from [dataLake].[USPO_10607] a
left join
(select
'USPO-10607' as RecordNum
,a.SampleID
,a.Sample_Date_Time
,a.Culture_Initiated_Date_Time_
,a.[Culture_Duration__Hours_]
,a.[Seeding_Concentration]
,a.batch_number as BatchNumber
,Right(a.batch_number,Len(a.batch_number) - 3) as MasterBatchNumber
,a.piecenumber
,a.Viability____
,a.Viable_Cell_Concentration
from [dataLake].[USPO_10607] a
where a.[Batch_Number] like '02%') b
on Right(a.batch_number,Len(a.batch_number) - 3) = b.MasterBatchNumber and a.piecenumber = b.piecenumber
left join [dataLake].[USPO_10605] c
on Right(a.batch_number,Len(a.batch_number) - 3) = Right(c.batch_number,Len(c.batch_number) - 3)
outer apply
(select top 1
c.Culture_Initiated_Date_Time_
,c.[Seeding_Concentration]
,c.Inoculum_Room_Number
,c.Media_Use_By_Date
,c.Incubator_ID
,c.Batch_Record_ID__sending_
,c.Batch_Number__sending_
from [dataLake].[USPO_10607] c
where a.[Batch_Number] = c.[Batch_Number] and c.Culture_Initiated_Date_Time_ is not null and c.[Seeding_Concentration] is not null
and c.[Batch_Number] like '01%'
order by c.[Batch_Number], c.[PieceNumber] desc) aprev
where a.[Batch_Number] like '01%'
--and a.Sample_Date_Time >= '2019-01-01'
--order by SampleDateTime desc,BatchNumber asc, PieceNumber asc
/*
--------------------------------
END of USPO-10607_01 Records
--------------------------------
*/
union all
/*
--------------------------------
START of USPO-10607_02 Records
--------------------------------
*/
--This is the USPO-10607 records again
--This section picks up 02_ records
select
'USPO-10607' as RecordNum
,a.SampleID as SampleID
,b.Sample_Date_Time as SampleDateTime
,a.Day_Number as DayNumber
,coalesce(a.Culture_Initiated_Date_Time_,aprev.Culture_Initiated_Date_Time_) as CultureInitiatedDateTime
,Cast(DateDiff(minute,coalesce(a.Culture_Initiated_Date_Time_,aprev.Culture_Initiated_Date_Time_),b.Sample_Date_Time)/60 as float) as CultureDurationAge
--,a.[Culture_Duration__Hours_] as CultureDurationAge
,coalesce(a.[Seeding_Concentration],aprev.[Seeding_Concentration]) as SeedingConcentration
,a.approvestatus as ApproveStatus
,a.product_name as ProductName
,a.batch_number as BatchNumber
,Right(a.batch_number,Len(a.batch_number) - 3) as MasterBatchNumber
,c.cell_bank_id as CellBankID
,c.ampoule_id as Ampoule_ID
,a.piecenumber as PieceNumber
,b.Viability____ as ViabilityPct
,b.Viable_Cell_Concentration as ViableCellConcentration
,a.generation_number as GenerationNumber
,a.Final_Volume__mL_ as FinalVolumemL
,coalesce(a.Inoculum_Room_Number,aprev.Inoculum_Room_Number) as InocRoomNumber
,coalesce(a.Media_Use_By_Date,aprev.Media_Use_By_Date)  as MediaUseByDate
,c.Thaw_Start_Date_Time as ThawStartDateTime
,c.Thaw_End_Date_Time as ThawEndDateTime
,case when a.Vessel_Size is null then 'Step 3 - 3L' else 'Step 3 - ' + a.Vessel_Size end as VesselSize
,coalesce(a.Incubator_ID,aprev.Incubator_ID) as IncubatorID
,coalesce(a.Batch_Record_ID__sending_,aprev.Batch_Record_ID__sending_) as BatchRecordID_Sending
,coalesce(a.Batch_Number__sending_,aprev.Batch_Number__sending_) as BatchNumberID_Sending
,0 as SuspectDataFlag
,(Log(b.Viable_Cell_Concentration)-Log(coalesce(a.[Seeding_Concentration],aprev.[Seeding_Concentration])))/cast((case when isnumeric(Cast(DateDiff(minute,coalesce(a.Culture_Initiated_Date_Time_,aprev.Culture_Initiated_Date_Time_),b.Sample_Date_Time)/60 as float))=1 then Cast(DateDiff(minute,coalesce(a.Culture_Initiated_Date_Time_,aprev.Culture_Initiated_Date_Time_),b.Sample_Date_Time)/60 as float) else null end) as float)  as GrowthRate
,Log(2)/NullIf(((Log(b.Viable_Cell_Concentration)-Log(coalesce(a.[Seeding_Concentration],aprev.[Seeding_Concentration])))/cast((case when isnumeric(Cast(DateDiff(minute,coalesce(a.Culture_Initiated_Date_Time_,aprev.Culture_Initiated_Date_Time_),b.Sample_Date_Time)/60 as float))=1 then Cast(DateDiff(minute,coalesce(a.Culture_Initiated_Date_Time_,aprev.Culture_Initiated_Date_Time_),b.Sample_Date_Time)/60 as float) else null end) as float)),0) as DoublingTime
from [dataLake].[USPO_10607] a
left join
(select
'USPO-10607' as RecordNum
,a.SampleID
,a.Sample_Date_Time
,a.Culture_Initiated_Date_Time as Culture_Initiated_Date_Time_
,a.[Culture_Duration__Hours_]
,a.[Seeding_Concentration]
,a.batch_number as BatchNumber
,Right(a.batch_number,Len(a.batch_number) - 3) as MasterBatchNumber
,a.piecenumber
,a.Viability____
,a.Viable_Cell_Concentration
from [dataLake].[USPO_10608] a
where a.[Batch_Number] like '01%'
and a.Day_Number > 0) b
on Right(a.batch_number,Len(a.batch_number) - 3) = b.MasterBatchNumber and a.piecenumber = b.piecenumber
left join [dataLake].[USPO_10605] c
on Right(a.batch_number,Len(a.batch_number) - 3) = Right(c.batch_number,Len(c.batch_number) - 3)
outer apply
(select top 1
c.Culture_Initiated_Date_Time_
,c.[Seeding_Concentration]
,c.Inoculum_Room_Number
,c.Media_Use_By_Date
,c.Incubator_ID
,c.Batch_Record_ID__sending_
,c.Batch_Number__sending_
from [dataLake].[USPO_10607] c
where a.[Batch_Number] = c.[Batch_Number] and c.Culture_Initiated_Date_Time_ is not null and c.[Seeding_Concentration] is not null
and c.[Batch_Number] like '02%'
order by c.[Batch_Number], c.[PieceNumber] desc) aprev
where a.[Batch_Number] like '02%'
--and a.Sample_Date_Time >= '2019-01-01'
--order by SampleDateTime desc,BatchNumber asc, PieceNumber asc
/*
--------------------------------
END of USPO-10607_02 Records
--------------------------------
*/
union all
/*
--------------------------------
START of USPO-10608 Records
--------------------------------
*/
select
'USPO-10608' as RecordNum
,a.SampleID as SampleID
,coalesce(b.Sample_Date_Time,d.Sample_Date_Time) as SampleDateTime
,a.Day_Number as DayNumber
,coalesce(a.Culture_Initiated_Date_Time,aprev.Culture_Initiated_Date_Time) as CultureInitiatedDateTime
,cast(DateDiff(minute,coalesce(a.Culture_Initiated_Date_Time,aprev.Culture_Initiated_Date_Time),coalesce(b.Sample_Date_Time,d.Sample_Date_Time))/60 as float) as CultureDurationAge
--,a.[Culture_Duration__Hours_] as CultureDurationAge
,2.5 as SeedingConcentration --coalesce(a.[Seeding_Concentration],aprev.[Seeding_Concentration]) as SeedingConcentration
,a.approvestatus as ApproveStatus
,a.product_name as ProductName
,a.batch_number as BatchNumber
,Right(a.batch_number,Len(a.batch_number) - 3) as MasterBatchNumber
,c.cell_bank_id as CellBankID
,c.ampoule_id as Ampoule_ID
,a.piecenumber as PieceNumber
,b.Viability____ as ViabilityPct
,b.Viable_Cell_Concentration as ViableCellConcentration
,a.generation_number as GenerationNumber
,a.[Post_Inoculation_Weight__Kg_]*1000 as FinalVolumemL
,coalesce(a.Inoculum_Room_Number,aprev.Inoculum_Room_Number) as InocRoomNumber
,coalesce(a.Media_Use_By_Date,aprev.Media_Use_By_Date)  as MediaUseByDate
,c.Thaw_Start_Date_Time as ThawStartDateTime
,c.Thaw_End_Date_Time as ThawEndDateTime
,'Step 4 - 20L'  as VesselSize
--,+ a.Vessel_Size
,null as IncubatorID
,coalesce(a.Batch_Record_ID__sending_,aprev.Batch_Record_ID__sending_) as BatchRecordID_Sending
,coalesce(a.Batch_Number__sending_,aprev.Batch_Number__sending_) as BatchNumberID_Sending
,0 as SuspectDataFlag
,(Log(b.Viable_Cell_Concentration)-Log(2.5))/cast((case when isnumeric((DateDiff(minute,coalesce(a.Culture_Initiated_Date_Time,aprev.Culture_Initiated_Date_Time),coalesce(b.Sample_Date_Time,d.Sample_Date_Time))/60))=1 then (DateDiff(minute,coalesce(a.Culture_Initiated_Date_Time,aprev.Culture_Initiated_Date_Time),coalesce(b.Sample_Date_Time,d.Sample_Date_Time))/60) else null end) as float)  as GrowthRate
,Log(2)/NullIf(((Log(b.Viable_Cell_Concentration)-Log(2.5))/cast((case when isnumeric(DateDiff(minute,coalesce(a.Culture_Initiated_Date_Time,aprev.Culture_Initiated_Date_Time),coalesce(b.Sample_Date_Time,d.Sample_Date_Time))/60)=1 then DateDiff(minute,coalesce(a.Culture_Initiated_Date_Time,aprev.Culture_Initiated_Date_Time),coalesce(b.Sample_Date_Time,d.Sample_Date_Time))/60 else null end) as float)),0) as DoublingTime
from [dataLake].[USPO_10608] a
left join
(select
'USPO-10609' as RecordNum
,max(a.SampleID) as SampleID
,max(a.Sample_Date_Time) as Sample_Date_Time
,max(a.Culture_Initiated_Date_Time) as Culture_Initiated_Date_Time
,Max(a.[Seeding_Concentration]) as Seeding_Concentration
,Right(a.batch_number,Len(a.batch_number) - 3) as MasterBatchNumber
,max(a.Viability____) as Viability____
,max(a.Viable_Cell_Concentration) as Viable_Cell_Concentration
from [dataLake].[USPO_10609] a
where
a.[Batch_Number] like '01%'
and
a.Day_Number > 0
group by
a.[Batch_Number]
) b
on Right(a.batch_number,Len(a.batch_number) - 3) = b.MasterBatchNumber
--and a.piecenumber = b.piecenumber

left join
(select
'USPO-10610' as RecordNum
,max(a.SampleID) as SampleID
,max(a.Sample_Date_Time) as Sample_Date_Time
,Max(a.[Seeding_Concentration]) as Seeding_Concentration
,Right(a.batch_number,Len(a.batch_number) - 3) as MasterBatchNumber
,max(a.Viability____) as Viability____
,max(a.Viable_Cell_Concentration) as Viable_Cell_Concentration
from [dataLake].[USPO_10610] a
where
a.[Batch_Number] like '01%'
and
a.Day_Number > 0
group by
a.[Batch_Number]
) d
on Right(a.batch_number,Len(a.batch_number) - 3) = d.MasterBatchNumber
--and a.piecenumber = d.piecenumber

left join [dataLake].[USPO_10605] c
on Right(a.batch_number,Len(a.batch_number) - 3) = Right(c.batch_number,Len(c.batch_number) - 3)
outer apply
(select top 1
c.Culture_Initiated_Date_Time
,c.[Seeding_Concentration]
,c.Inoculum_Room_Number
,c.Media_Use_By_Date
,c.Batch_Record_ID__sending_
,c.Batch_Number__sending_
from [dataLake].[USPO_10608] c
where a.[Batch_Number] = c.[Batch_Number] and c.Culture_Initiated_Date_Time is not null --and c.[Seeding_Concentration] is not null
and c.[Batch_Number] like '01%'
order by c.[Batch_Number], c.[PieceNumber] desc) aprev
where
a.[Batch_Number] like '01%'
and
a.day_number = 0
--and a.Sample_Date_Time >= '2019-01-01'
/*
--------------------------------
END of USPO-10608 Records
--------------------------------
*/
union all
/*
--------------------------------
START of USPO-10609 Records
--------------------------------
*/
select
'USPO-10609' as RecordNum
,a.SampleID as SampleID
,coalesce(b.Sample_Date_Time,d.Sample_Date_Time) as SampleDateTime
,a.Day_Number as DayNumber
,coalesce(a.Culture_Initiated_Date_Time,aprev.Culture_Initiated_Date_Time) as CultureInitiatedDateTime
,cast(DateDiff(minute,coalesce(a.Culture_Initiated_Date_Time,aprev.Culture_Initiated_Date_Time),coalesce(b.Sample_Date_Time,d.Sample_Date_Time))/60 as float) as CultureDurationAge
--,a.[Culture_Duration__Hours_] as CultureDurationAge
,a.Viable_Cell_Concentration as SeedingConcentration
--,coalesce(a.[Seeding_Concentration],aprev.[Seeding_Concentration]) as SeedingConcentration
--,2.5 as SeedingConcentration --coalesce(a.[Seeding_Concentration],aprev.[Seeding_Concentration]) as SeedingConcentration
,a.approvestatus as ApproveStatus
,a.product_name as ProductName
,a.batch_number as BatchNumber
,Right(a.batch_number,Len(a.batch_number) - 3) as MasterBatchNumber
,c.cell_bank_id as CellBankID
,c.ampoule_id as Ampoule_ID
,a.piecenumber as PieceNumber
,b.Viability____ as ViabilityPct
,b.Viable_Cell_Concentration as ViableCellConcentration
,a.generation_number as GenerationNumber
,a.[Total_Fill_Weight__Kg_]*1000 as FinalVolumemL
,null as InocRoomNumber
,coalesce(a.Media_Use_By_Date,aprev.Media_Use_By_Date)  as MediaUseByDate
,c.Thaw_Start_Date_Time as ThawStartDateTime
,c.Thaw_End_Date_Time as ThawEndDateTime
,'Step 4 - 20L'  as VesselSize
--,+ a.Vessel_Size
,null as IncubatorID
,coalesce(a.Batch_Record_ID__sending_,aprev.Batch_Record_ID__sending_) as BatchRecordID_Sending
,coalesce(a.Batch_Number__sending_,aprev.Batch_Number__sending_) as BatchNumberID_Sending
,0 as SuspectDataFlag
,(Log(b.Viable_Cell_Concentration)-Log(a.Viable_Cell_Concentration))/cast((case when isnumeric((DateDiff(minute,coalesce(a.Culture_Initiated_Date_Time,aprev.Culture_Initiated_Date_Time),coalesce(b.Sample_Date_Time,d.Sample_Date_Time))/60))=1 then (DateDiff(minute,coalesce(a.Culture_Initiated_Date_Time,aprev.Culture_Initiated_Date_Time),coalesce(b.Sample_Date_Time,d.Sample_Date_Time))/60) else null end) as float)  as GrowthRate
,Log(2)/NullIf(((Log(b.Viable_Cell_Concentration)-Log(a.Viable_Cell_Concentration))/cast((case when isnumeric(DateDiff(minute,coalesce(a.Culture_Initiated_Date_Time,aprev.Culture_Initiated_Date_Time),coalesce(b.Sample_Date_Time,d.Sample_Date_Time))/60)=1 then DateDiff(minute,coalesce(a.Culture_Initiated_Date_Time,aprev.Culture_Initiated_Date_Time),coalesce(b.Sample_Date_Time,d.Sample_Date_Time))/60 else null end) as float)),0) as DoublingTime
from [dataLake].[USPO_10609] a
left join
(select
'USPO-10609' as RecordNum
,max(a.SampleID) as SampleID
,max(a.Sample_Date_Time) as Sample_Date_Time
,max(a.Culture_Initiated_Date_Time) as Culture_Initiated_Date_Time
,Max(a.[Seeding_Concentration]) as Seeding_Concentration
,Right(a.batch_number,Len(a.batch_number) - 3) as MasterBatchNumber
,max(a.Viability____) as Viability____
,max(a.Viable_Cell_Concentration) as Viable_Cell_Concentration
from [dataLake].[USPO_10609] a
where
a.[Batch_Number] like '02%'
and
a.Day_Number > 0
group by
a.[Batch_Number]
) b
on Right(a.batch_number,Len(a.batch_number) - 3) = b.MasterBatchNumber
--and a.piecenumber = b.piecenumber

left join
(select
'USPO-10610' as RecordNum
,max(a.SampleID) as SampleID
,max(a.Sample_Date_Time) as Sample_Date_Time
,Max(a.[Seeding_Concentration]) as Seeding_Concentration
,Right(a.batch_number,Len(a.batch_number) - 3) as MasterBatchNumber
,max(a.Viability____) as Viability____
,max(a.Viable_Cell_Concentration) as Viable_Cell_Concentration
from [dataLake].[USPO_10610] a
where
a.[Batch_Number] like '01%'
and
a.Day_Number > 0
group by
a.[Batch_Number]
) d
on Right(a.batch_number,Len(a.batch_number) - 3) = d.MasterBatchNumber
--and a.piecenumber = d.piecenumber

left join [dataLake].[USPO_10605] c
on Right(a.batch_number,Len(a.batch_number) - 3) = Right(c.batch_number,Len(c.batch_number) - 3)
outer apply
(select top 1
c.Culture_Initiated_Date_Time
,c.[Seeding_Concentration]
,c.Media_Use_By_Date
,c.Batch_Record_ID__sending_
,c.Batch_Number__sending_
from [dataLake].[USPO_10609] c
where a.[Batch_Number] = c.[Batch_Number] and c.Culture_Initiated_Date_Time is not null --and c.[Seeding_Concentration] is not null
and c.[Batch_Number] like '01%'
and c.Day_number = 0
order by c.[Batch_Number], c.[PieceNumber] desc) aprev
where
a.[Batch_Number] like '01%'
and
a.day_number = 0
--and a.Sample_Date_Time >= '2019-01-01'
/*
--------------------------------
END of USPO-10609 Records
--------------------------------
*/) batch
left join [dataLake].[process_monitoring_targets] t
on batch.RecordNum = t.RecordNumber and batch.ProductName = t.CustomerNumber


       ;;

 # persist_for: "24 hours"
  }

  set: process_details {
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
      doubling_time,
      vcc_target_min,
      vcc_target_mean,
      vcc_target_max,
      viability_target_min,
      viability_target_mean,
      viability_target_max,
      duration_target_min,
      duration_target_mean,
      duration_target_max,
      growth_rate_target_min,
      growth_rate_target_mean,
      growth_rate_target_max,
      doubling_time_target_min,
      doubling_time_target_mean,
      doubling_time_target_max
    ]
    }


  parameter: dimension_selector{
    type: string
    description: "This fields allow for dynamic dimension selection. It must be used in conjunction with the Reporting Dimension."
    allowed_value: {
      label: "By Record Number"
      value: "recordnum"
    }
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
      label: "By Generation"
      value: "generation"
    }

    allowed_value: {
      label: "By Cell Bank ID"
      value: "cellbank"
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
    {% elsif dimension_selector._parameter_value == "'recordnum'"%}
    ${record_num}
    {% elsif dimension_selector._parameter_value == "'masterbatch'"%}
    ${master_batch_number}
    {% elsif dimension_selector._parameter_value == "'vessel'"%}
    ${vessel_size}
    {% elsif dimension_selector._parameter_value == "'generation'"%}
    ${generation_number}
    {% elsif dimension_selector._parameter_value == "'cellbank'"%}
    ${cell_bank_id}
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
    drill_fields: [process_details*]
  }

  dimension: max_batch_id {
    label: "Max Batch ID"
    type: number
    sql: max(${master_batch_number} ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: distinct_master_batches {
    label: "Number of Distinct Master Batches"
    type: count_distinct
    sql: ${master_batch_number} ;;
    drill_fields: [process_details*]
  }

  measure: distinct_batches {
    label: "Number of Distinct Batches"
    type: count_distinct
    sql: ${batch_number} ;;
    drill_fields: [process_details*]
  }

  measure: distinct_samples {
    label: "Number of Distinct Samples"
    type: count_distinct
    sql: ${sample_id} ;;
    drill_fields: [process_details*]
  }

  measure: growth_rate_value {
    type: average
    sql: ${TABLE}.GrowthRate ;;
    drill_fields: [process_details*]
  }

  measure: doubling_time_value {
    type: average
    sql: ${TABLE}.DoublingTime ;;
    drill_fields: [process_details*]
  }

  measure: growth_rate_mean {
    label: "Mean Growth Rate"
    type:  average
    sql: ${TABLE}.GrowthRate ;;
    drill_fields: [process_details*]
  }


  measure: growth_rate_min {
    label: "Min. Growth Rate"
    type:  min
    sql: ${TABLE}.GrowthRate ;;
    drill_fields: [process_details*]
  }


  measure: growth_rate_max {
    label: "Max Growth Rate"
    type:  max
    sql: ${TABLE}.GrowthRate ;;
    drill_fields: [process_details*]
  }


  measure: doublingtime_mean {
    label: "Mean Doubling Time"
    type:  average
    sql: ${TABLE}.DoublingTime ;;
    #drill_fields: [process_details*]
    link: {label: "Explore Results" url: "{{ link }}" }
  }


  measure: doublingtime_min {
    label: "Min. Doubling Time"
    type:  min
    sql: ${TABLE}.DoublingTime ;;
    drill_fields: [process_details*]
  }


  measure: doublingtime_max {
    label: "Max Doubling Time"
    type:  max
    sql: ${TABLE}.DoublingTime ;;
    drill_fields: [process_details*]
  }

  measure: viability_pct_value {
    label: "Avg. Viability Pct"
    type: average
    sql: ${TABLE}.ViabilityPct ;;
    drill_fields: [process_details*]
  }

  measure: viable_cell_concentration_value {
    label: "Avg. VCC"
    type: average
    sql: ${TABLE}.ViableCellConcentration ;;
    drill_fields: [process_details*]
  }

  measure: average_duration {
    label: "Average Duration"
    type: average
    sql: ${TABLE}.CultureDurationAge ;;
    drill_fields: [process_details*]
  }

  measure: max_duration {
    label: "Max Duration"
    type: max
    sql: ${TABLE}.CultureDurationAge ;;
    drill_fields: [process_details*]
  }

  measure: min_duration {
    label: "Min Duration"
    type: min
    sql: ${TABLE}.CultureDurationAge ;;
    drill_fields: [process_details*]
  }

  measure: vcc_min_target{
   label: "Target Min VCC"
   type: average
   sql: ${vcc_target_min} ;;
  }

  measure: vcc_max_target{
    label: "Target Max VCC"
    type: average
    sql: ${vcc_target_max} ;;
  }

  measure: viability_min_target{
    label: "Target Min Viability"
    type: average
    sql: ${viability_target_min} ;;
    }

  measure: viability_max_target{
    label: "Target Max Viability"
    type: average
    sql: ${viability_target_max} ;;
  }

  measure: duration_min_target{
    label: "Target Min Duration"
    type: average
    sql: ${duration_target_min} ;;
  }

  measure: duration_max_target{
    label: "Target Max Duration"
    type: average
    sql: ${duration_target_max} ;;
  }

  measure: growth_rate_min_target{
    label: "Target Min Growth Rate"
    type: average
    sql: ${growth_rate_target_min} ;;
  }

  measure: growth_rate_max_target{
    label: "Target Max Growth Rate"
    type: average
    sql: ${growth_rate_target_max} ;;
  }

  measure: doubling_time_min_target{
    label: "Target Min Doubling Time"
    type: average
    sql: ${doubling_time_target_min} ;;
  }

  measure: doubling_time_max_target{
    label: "Target Max Doubling Time"
    type: average
    sql: ${doubling_time_target_max} ;;
  }


  dimension: record_num {
    type: string
    sql: ${TABLE}.recordnum ;;
    #drill_fields: [detail*]
    link: {
      label: "Drill-down"
      url: "/dashboards/zmUjIWwHCXijsuqSROOzMq?Record%20Number={{ value }}"
      icon_url: "https://www.shareicon.net/download/128x128//2016/09/01/822259_medical_512x512.png"
    }
  }

  dimension: daynumber {
    type: number
    sql: ${TABLE}.DayNumber ;;
   # drill_fields: [detail*]
  }
  dimension: sample_id {
    type: number
    sql: ${TABLE}.SampleID ;;
    drill_fields: [detail*]
  }

  dimension_group: sample_date_time {
    label: "Sample Date-Time"
    type: time
    timeframes: [date,hour_of_day,week,week_of_year,day_of_week,day_of_month,month_name, month,quarter,quarter_of_year,year]
    sql: ${TABLE}.SampleDateTime ;;
    #drill_fields: [detail*]
  }

  dimension: culture_initiated_date_time {
    type: string
    sql: ${TABLE}.CultureInitiatedDateTime ;;
    #drill_fields: [detail*]
  }

  dimension: culture_duration_age {
    type: number
    sql: ${TABLE}.CultureDurationAge ;;
   # drill_fields: [detail*]
  }

  dimension: seeding_concentration {
    type: number
    sql: ${TABLE}.SeedingConcentration ;;
  #  drill_fields: [detail*]
  }

  dimension: approve_status {
    type: number
    sql: ${TABLE}.ApproveStatus ;;
   # drill_fields: [detail*]
  }

  dimension: product_name {
    type: string
    sql: ${TABLE}.ProductName ;;
   # drill_fields: [detail*]
  }

  dimension: batch_number {
    type: string
    sql: ${TABLE}.BatchNumber ;;
  #  drill_fields: [detail*]
    link: {
      label: "Drill-down"
      url: "/dashboards/zmUjIWwHCXijsuqSROOzMq?Batch%20Number={{ value }}"
      icon_url: "https://www.shareicon.net/download/128x128//2016/09/01/822259_medical_512x512.png"
    }
  }

  dimension: master_batch_number {
    type: string
    sql: ${TABLE}.MasterBatchNumber ;;
  #  drill_fields: [detail*]
    link: {
      label: "Drill-down"
      url: "/dashboards/zmUjIWwHCXijsuqSROOzMq?Master%20Batch={{ value }}"
      icon_url: "https://www.shareicon.net/download/128x128//2016/09/01/822259_medical_512x512.png"
    }
  }

  dimension: cell_bank_id {
    type: string
    sql: ${TABLE}.CellBankID ;;
  #  drill_fields: [detail*]
  }

  dimension: ampoule_id {
    type: string
    sql: ${TABLE}.Ampoule_ID ;;
  #  drill_fields: [detail*]
  }

  dimension: piece_number {
    type: number
    sql: ${TABLE}.PieceNumber ;;
  #  drill_fields: [detail*]
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
    drill_fields: [detail*]
  }

  dimension: final_volumem_l {
    type: number
    sql: ${TABLE}.FinalVolumemL ;;
    drill_fields: [detail*]
  }

  dimension: inoc_room_number {
    type: string
    sql: ${TABLE}.InocRoomNumber ;;
    drill_fields: [detail*]
  }

  dimension: media_use_by_date {
    type: string
    sql: ${TABLE}.MediaUseByDate ;;
    drill_fields: [detail*]
  }

  dimension: thaw_start_date_time {
    type: string
    sql: ${TABLE}.ThawStartDateTime ;;
    drill_fields: [detail*]
  }

  dimension: thaw_end_date_time {
    type: string
    sql: ${TABLE}.ThawEndDateTime ;;
    drill_fields: [detail*]
  }

  dimension: vessel_size {
    type: string
    sql: ${TABLE}.VesselSize ;;
    drill_fields: [process_details*]
    link: {
      label: "Drill-down"
      url: "/dashboards/zmUjIWwHCXijsuqSROOzMq?Vessel%20Size={{ value }}"
      icon_url: "https://www.shareicon.net/download/128x128//2016/09/01/822259_medical_512x512.png"
    }
  }

  dimension: incubator_id {
    type: string
    sql: ${TABLE}.IncubatorID ;;
    drill_fields: [detail*]
  }

  dimension: batch_record_id_sending {
    type: string
    sql: ${TABLE}.BatchRecordID_Sending ;;
    drill_fields: [detail*]
  }

  dimension: batch_number_id_sending {
    type: string
    sql: ${TABLE}.BatchNumberID_Sending ;;
    drill_fields: [detail*]
  }

  dimension: suspect_data_flag {
    type: number
    sql: ${TABLE}.SuspectDataFlag ;;
    drill_fields: [detail*]
  }

  dimension: growth_rate {
    type: number
    sql: ${TABLE}.GrowthRate ;;
    drill_fields: [detail*]
  }

  dimension: doubling_time {
    type: number
    sql: ${TABLE}.DoublingTime ;;
    drill_fields: [detail*]
  }

  dimension: vcc_target_min {
    type: number
    sql: ${TABLE}.VCC_TargetMin ;;
  }

  dimension: vcc_target_mean {
    type: number
    sql: ${TABLE}.VCC_TargetMean ;;
  }

  dimension: vcc_target_max {
    type: number
    sql: ${TABLE}.VCC_TargetMax ;;
  }

  dimension: viability_target_min {
    type: number
    sql: ${TABLE}.Viability_TargetMin ;;
  }

  dimension: viability_target_mean {
    type: number
    sql: ${TABLE}.Viability_TargetMean ;;
  }

  dimension: viability_target_max {
    type: number
    sql: ${TABLE}.Viability_TargetMax ;;
  }

  dimension: duration_target_min {
    type: number
    sql: ${TABLE}.Duration_TargetMin ;;
  }

  dimension: duration_target_mean {
    type: number
    sql: ${TABLE}.Duration_TargetMean ;;
  }

  dimension: duration_target_max {
    type: number
    sql: ${TABLE}.Duration_TargetMax ;;
  }

  dimension: growth_rate_target_min {
    type: number
    sql: ${TABLE}.GrowthRate_TargetMin ;;
  }

  dimension: growth_rate_target_mean {
    type: number
    sql: ${TABLE}.GrowthRate_TargetMean ;;
  }

  dimension: growth_rate_target_max {
    type: number
    sql: ${TABLE}.GrowthRate_TargetMax ;;
  }

  dimension: doubling_time_target_min {
    type: number
    sql: ${TABLE}.DoublingTime_TargetMin ;;
  }

  dimension: doubling_time_target_mean {
    type: number
    sql: ${TABLE}.DoublingTime_TargetMean ;;
  }

  dimension: doubling_time_target_max {
    type: number
    sql: ${TABLE}.DoublingTime_TargetMax ;;
  }

 # dimension: customer_number {
  #  hidden: yes
  #  type: number
   # sql: ${TABLE}.CustomerNumber ;;
  #}

  #dimension: record_number {
  #  hidden: yes
  #  type: string
  #  sql: ${TABLE}.RecordNum ;;
  #}

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
      doubling_time,
#       customer_number,
#      record_number,
      vcc_target_min,
      vcc_target_mean,
      vcc_target_max,
      viability_target_min,
      viability_target_mean,
      viability_target_max,
      duration_target_min,
      duration_target_mean,
      duration_target_max,
      growth_rate_target_min,
      growth_rate_target_mean,
      growth_rate_target_max,
      doubling_time_target_min,
      doubling_time_target_mean,
      doubling_time_target_max
    ]
  }
}
