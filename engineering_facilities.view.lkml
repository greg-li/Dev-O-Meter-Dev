view: engineering_facilities {
  derived_table: {
    sql:
  SELECT r.[OrderNo]
      ,r.[OrderType]
      ,r.[MaintActivType]
      ,r.[Description]
      ,r.[MaintenancePlan]
      ,r.[MainWorkCenter]
      ,r.[FunctionalLocation]
    ,null as Equipment
      ,r.[Priority]
    ,r.[CreatedOn]
      ,case when r.Priority = 1
    then dateadd(d,1,r.createdon)
    when r.Priority=2
    then dateadd(d,2,r.createdon)
    when r.Priority=3
    then dateadd(d,10,r.createdon)
    when r.Priority=4
    then dateadd(d,30,r.createdon)
    when r.Priority=5
    then dateadd(d,180,r.createdon)
    end as PlanDate
    ,null as LateDate
    ,'Engineering/Faciitites' as Function_Mapping
    ,r.[LoadID]
    ,r.[LoadDate]
  ,t.TechCompletion
  FROM [EDM].[dataLake].[RequestedWork_Excel_EngAndFacilities] r
  LEFT JOIN edm.datalake.TECO_Excel_EngAndFacilities t
  on r.orderno = t.orderno
  where r.loadid = (select max(loadid) from [EDM].[dataLake].[RequestedWork_Excel_EngAndFacilities])
  union all
  SELECT
     p.[OrderNo]
    ,p.[Type] as OrderType
    ,null as MaintActivType
    ,p.[Description]
    ,p.[MaintenancePlan]
    ,p.[MainWorkCenter]
    ,p.[FunctionalLocation]
    ,p.[Equipment]
    ,null as Priority
    ,p.[Release] as CreatedOn
    ,p.[PlanDate]
    ,p.[LateDate]
    ,'Engineering/Faciitites' as Function_Mapping
    ,p.[LoadID]
    ,p.[LoadDate]
    ,t.TechCompletion
  FROM [EDM].[dataLake].[PMOP_txt_EngAndFacilities] p
  LEFT JOIN edm.datalake.TECO_Excel_EngAndFacilities t
  on p.orderno = t.orderno
  where p.loadid = (select max(loadid) from [EDM].[dataLake].[PMOP_txt_EngAndFacilities])
 ;;

 persist_for: "24 hours"
  indexes: ["orderno"]
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: count_of_wo {
    type: count_distinct
  }

  measure: count_PMOP {
    label: "Number of PMOP Orders"
    filters: {
      field: order_type
      value: "PMOP"
    }
    type: count
  }

  measure: count_BDOP {
    label: "Number of BDOP Orders"
    filters: {
      field: order_type
      value: "BDOP"
    }
    type: count
  }

  measure: count_PCOP {
    label: "Number of PCOP Orders"
    filters: {
      field: order_type
      value: "PCOP"
    }
    type: count
  }

  measure: count_RMOP {
    label: "Number of RMOP Orders"
    filters: {
      field: order_type
      value: "RMOP"
    }
    type: count
    }

    measure: count_of_non_PM {
      label: "Number of Non-PMOPs"
      filters: {
        field: order_type
        value: "PCOP,RMOP,BDOP"
      }
      type: count
      }

  dimension:  TechCompletion {
    type: date
    sql: ${TABLE}.TechCompletion;;
  }

  dimension: Function_Mapping {
  type: string
  sql:  ${TABLE}.Function_Mapping;;
  }

  dimension: order_no {
    type: number
    sql: ${TABLE}.OrderNo ;;
  }

  dimension: order_type {
    type: string
    sql: ${TABLE}.OrderType ;;
  }

  dimension: maint_activ_type {
    type: string
    sql: ${TABLE}.MaintActivType ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}.Description ;;
  }

  dimension: maintenance_plan {
    type: string
    sql: ${TABLE}.MaintenancePlan ;;
  }

  dimension: main_work_center {
    type: string
    sql: ${TABLE}.MainWorkCenter ;;
  }

  dimension: functional_location {
    type: string
    sql: ${TABLE}.FunctionalLocation ;;
  }

  dimension: equipment {
    type: string
    sql: ${TABLE}.Equipment ;;
  }

  dimension: priority {
    type: string
    sql: ${TABLE}.Priority ;;
  }

  dimension_group: created_on {
    type: time
    sql: ${TABLE}.CreatedOn ;;
  }

  dimension_group: plan_date {
    type: time
    sql: ${TABLE}.PlanDate ;;
  }

  dimension_group: late_date {
    type: time
    sql: ${TABLE}.LateDate ;;
  }

  set: detail {
    fields: [
      order_no,
      order_type,
      maint_activ_type,
      description,
      maintenance_plan,
      main_work_center,
      functional_location,
      equipment,
      priority,
      created_on_date,
      plan_date_time,
      late_date_time,
      Function_Mapping
    ]
  }
}
