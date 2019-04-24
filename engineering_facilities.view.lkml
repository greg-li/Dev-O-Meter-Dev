view: engineering_facilities {
  derived_table: {
    sql:
    with orders as
(SELECT [OrderNo]
      ,[OrderType]
      ,[MaintActivType]
      ,[Description]
      ,[MaintenancePlan]
      ,[MainWorkCenter]
      ,[FunctionalLocation]
    ,null as Equipment
      ,[Priority]
    ,[CreatedOn]
    ,null as Release
    ,null as PlanDate
    ,null as LateDate
    ,'Engineering/Faciitites' as Function_Mapping
    ,[LoadID]
    ,[LoadDate]
  FROM [EDM].[dataLake].[RequestedWork_Excel_EngAndFacilities]
  where loadid = (select max(loadid) from [EDM].[dataLake].[RequestedWork_Excel_EngAndFacilities])
  union all
  SELECT
       [OrderNo]
    ,[Type] as OrderType
    ,null as MaintActivType
      ,[Description]
    ,[MaintenancePlan]
    ,[MainWorkCenter]
    ,[FunctionalLocation]
      ,[Equipment]
    ,null as Priority
    ,null as CreatedOn
      ,[Release]
      ,[PlanDate]
      ,[LateDate]
    ,'Engineering/Faciitites' as Function_Mapping
    ,[LoadID]
    ,[LoadDate]
  FROM [EDM].[dataLake].[PMOP_txt_EngAndFacilities]
    where loadid = (select max(loadid) from [EDM].[dataLake].[PMOP_txt_EngAndFacilities])
  )

  select
  orders.*
  ,t.TechCompletion
  from  orders
  left join [EDM].[dataLake].TECO_Excel_EngAndFacilities t
  on orders.OrderNo = t.OrderNo


 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
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

  measure: PM_Percentage {
    label: "Pct of PMOP Over Total"
    type: number
    value_format_name: percent_2
    sql: ${count_PMOP}/ NULLIF(${count},0) ;;
  }

  measure: BDOP_Percentage {
    label: "Pct of BDOP Over Total"
    type: number
    value_format_name: percent_2
    sql: ${count_BDOP}/ NULLIF(${count},0) ;;
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

  dimension_group: release {
    type: time
    sql: ${TABLE}.Release ;;
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
      created_on_time,
      release_time,
      plan_date_time,
      late_date_time,
      Function_Mapping
    ]
  }
}
