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
    end as LateDate
    ,'Engineering/Facilities' as Function_Mapping
    ,r.[LoadID]
    ,r.[LoadDate]
  ,t.TechCompletion
  FROM [EDM].[dataLake].[RequestedWork_Excel_EngAndFacilities] r
  LEFT JOIN edm.datalake.TECO_Excel_EngAndFacilities t
  on r.orderno = t.orderno
  and t.loadid = (select max(loadid) from datalake.TECO_Excel_EngAndFacilities)
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
    ,'Engineering/Facilities' as Function_Mapping
    ,p.[LoadID]
    ,p.[LoadDate]
    ,t.TechCompletion
  FROM [EDM].[dataLake].[PMOP_txt_EngAndFacilities] p
  LEFT JOIN edm.datalake.TECO_Excel_EngAndFacilities t
  on p.orderno = t.orderno
  and t.loadid = (select max(loadid) from datalake.TECO_Excel_EngAndFacilities)
  where p.loadid = (select max(loadid) from [EDM].[dataLake].[PMOP_txt_EngAndFacilities])
 ;;

 persist_for: "24 hours"
  indexes: ["orderno"]
  }

  set: workorder_details {
    fields: [order_no,order_type,description,maint_activ_type,main_work_center,functional_location,equipment,created_on_date,plan_date_date,late_date_date,TechCompletion_date]
  }

  measure: count {
    type: count
    drill_fields: [workorder_details*]
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
    drill_fields: [workorder_details*]
  }

  measure: count_BDOP {
    label: "Number of BDOP Orders"
    filters: {
      field: order_type
      value: "BDOP"
    }
    type: count
    drill_fields: [workorder_details*]
  }

  measure: count_PCOP {
    label: "Number of PCOP Orders"
    filters: {
      field: order_type
      value: "PCOP"
    }
    type: count
    drill_fields: [workorder_details*]
  }

  measure: count_RMOP {
    label: "Number of RMOP Orders"
    filters: {
      field: order_type
      value: "RMOP"
    }
    type: count
    drill_fields: [workorder_details*]
    }

    measure: count_of_non_PM {
      label: "Number of Non-PMOPs"
      filters: {
        field: order_type
        value: "PCOP,RMOP,BDOP"
      }
      type: count
      drill_fields: [workorder_details*]
      }

    measure: pct_bdops_of_total {
      label: "Percent BDOP Orders over Total"
      value_format_name: percent_0
      type:  number
      sql:  1.0*  ${count_BDOP}/${count};;
    }


  measure: pct_pmops_of_total {
    label: "Percent PMOP Orders over Total"
    value_format_name: percent_0
    type:  number
    sql: 1.0* ${count_PMOP}/${count};;
  }

  measure: workorders_ontime {
    label: "Number of Work Orders On Time"
    type:  count_distinct
    sql: ${order_no};;
    filters: {
      field: late_date_date
      value: "after today"
    }
    filters: {
      field: TechCompletion_date
      value: "NULL"
    }
    drill_fields: [workorder_details*]
  }

  measure: workorders_late {
    label: "Number of Work Orders Late"
    type:  count_distinct
    sql: ${order_no};;
    filters: {
      field: late_date_date
      value: "before today"
    }
    filters: {
      field: TechCompletion_date
      value: "NULL"
    }
    drill_fields: [workorder_details*]
  }

  dimension: is_prior_ytd {
    type:  yesno
    hidden:  yes
    sql:
    ${created_on_date} BETWEEN DATEADD(yy, DATEDIFF(yy,0,DATEADD(yy, -1, GETDATE())), 0) AND DATEADD(yy, -1, GETDATE());;
  }

  dimension: is_current_ytd {
    type:  yesno
    hidden:  yes
    sql:
    ${created_on_date} BETWEEN DATEADD(yy, DATEDIFF(yy,0,GETDATE()), 0) AND GETDATE();;
  }

  measure: wo_count_ytd {
    type: count_distinct
    label: "Count of Work Orders Year-to-Date"
    sql: ${order_no};;
    drill_fields: [workorder_details*]
    filters: {
      field: is_current_ytd
      value: "yes"
    }
  }

  measure: wo_count_pytd {
    type: count_distinct
    label: "Count of Work Orders Prior Year-to-Date"
    sql: ${order_no};;
    drill_fields: [workorder_details*]
    filters: {
      field: is_prior_ytd
      value: "yes"
    }
  }

    dimension_group:  TechCompletion {
    timeframes: [date,hour_of_day,week,week_of_year,day_of_week,day_of_month,month_name, month,quarter,quarter_of_year,year]
    type: time
    sql: ${TABLE}.TechCompletion;;
  }


  dimension: date_diff_open_close {
    label: "Days between Open to TECO"
    type: number
    sql: datediff(day,${created_on_date},${TechCompletion_date}) ;;
  }

  measure: average_days_between_open_close {
    type: average
    sql: 1.0 * ${date_diff_open_close};;
    value_format_name: decimal_2
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
    drill_fields: [workorder_details*]
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
    drill_fields: [workorder_details*]
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
