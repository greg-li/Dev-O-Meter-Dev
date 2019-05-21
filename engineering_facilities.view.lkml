view: engineering_facilities {
  derived_table: {
    sql:
 SELECT
       r.[OrderNo]
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
    then dateadd(d,0,r.createdon)
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
    then dateadd(d,0,r.createdon)
    when r.Priority=2
    then dateadd(d,2,r.createdon)
    when r.Priority=3
    then dateadd(d,10,r.createdon)
    when r.Priority=4
    then dateadd(d,30,r.createdon)
    when r.Priority=5
    then dateadd(d,180,r.createdon)
    end as LateDate
    ,r.[LoadID]
    ,r.[LoadDate]
    ,t.TechCompletion
    ,case when r.[OrderType] not in ('BDOP','PMOP')
    then 'OTHER'
    else r.[OrderType]
    end as reporting_order_type
    ,case when r.[MainWorkCenter] in (
                   'BILDGS'
                  ,'CONTRACT'
                  ,'ELECTRIC'
                  ,'MECHANIC'
                  ,'HVAC'
                  ,'UTILITIE'
                  ,'SUIMAINT'
                  ,'ELASTMR'
                  ,'CALIBRAT'
                  ,'CALCCMX'
                  ,'ENGINEER'
                  ,'NIGHTS')
     then 'ENGINEERING'
     else 'ALL OTHERS'
     end as EngineeringReportingFlag
  ,case
    when r.[FunctionalLocation] like 'P01%' then '5k'
    when r.[FunctionalLocation] like 'P03%' then '5k'
    when r.[FunctionalLocation] like 'P02%' then '20k'
    when r.[FunctionalLocation] like 'P04%' then '20k'
    when r.[FunctionalLocation] like 'P09%' then 'Mono'
    when r.[FunctionalLocation] like 'P10%' then 'Mono'
    when r.[FunctionalLocation] like 'P08%' then 'CT'
    else 'Engineering/Facilities'
    end as Function_Mapping
  ,case when r.[SystemStatus] like 'CLSD%' or r.[SystemStatus] like 'TECO%'
  then 'CLOSED'
  else 'OPEN'
  end as OrderStatus
  ,case when r.[SystemStatus] like 'CLSD%' or r.[SystemStatus] like 'TECO%'
  then r.[ReferenceDate]
  else null
  end as ClosedDate
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
    ,p.[LoadID]
    ,p.[LoadDate]
    ,t.TechCompletion
    ,case when p.[Type] not in ('BDOP','PMOP')
    then 'OTHER'
    else p.[Type]
    end as reporting_order_type
    ,case when p.[MainWorkCenter] in (
                   'BILDGS'
                  ,'CONTRACT'
                  ,'ELECTRIC'
                  ,'MECHANIC'
                  ,'HVAC'
                  ,'UTILITIE'
                  ,'SUIMAINT'
                  ,'ELASTMR'
                  ,'CALIBRAT'
                  ,'CALCCMX'
                  ,'ENGINEER'
                  ,'NIGHTS')
  then 'ENGINEERING'
  else 'ALL OTHERS'
  end as EngineeringReportingFlag
    ,case
    when p.[FunctionalLocation] like 'P01%' then '5k'
    when p.[FunctionalLocation] like 'P03%' then '5k'
    when p.[FunctionalLocation] like 'P02%' then '20k'
    when p.[FunctionalLocation] like 'P04%' then '20k'
    when p.[FunctionalLocation] like 'P09%' then 'Mono'
    when p.[FunctionalLocation] like 'P10%' then 'Mono'
    when p.[FunctionalLocation] like 'P08%' then 'CT'
    else 'Engineering/Facilities'
    end as Function_Mapping
  ,case when p.[SystemStatus] like 'CLSD%' or p.[SystemStatus] like 'TECO%'
  then 'CLOSED'
  else 'OPEN'
  end as OrderStatus
  ,case when p.[SystemStatus] like 'CLSD%' or p.[SystemStatus] like 'TECO%'
  then p.[RefDate]
  else null
  end as ClosedDate
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
    fields: [order_no,order_type,description,maint_activ_type,main_work_center,functional_location,equipment,created_on_date,plan_date_date,late_date_date,ClosedDate_date,TechCompletion_date]
  }

  measure: count {
    type: count
    drill_fields: [workorder_details*]
  }

  measure: count_of_wo {
    type: count_distinct
  }

  measure: count_ {}

  measure: count_PMOP {
    label: "Number of PMOP Orders"
    filters: {
      field: order_type
      value: "PMOP"
    }
    type: count
    drill_fields: [workorder_details*]
    link: {
      label: "Engineering & Facilities Details"
      url: "/embed/dashboards/uo5bLXwHSFUbskkFeAidva"
      icon_url: "https://img.icons8.com/metro/26/000000/maintenance.png"
    }
  }

  measure: count_BDOP {
    label: "Number of BDOP Orders"
    filters: {
      field: order_type
      value: "BDOP"
    }
    type: count
    drill_fields: [workorder_details*]
    link: {
      label: "Engineering & Facilities Details"
      url: "/embed/dashboards/uo5bLXwHSFUbskkFeAidva"
      icon_url: "https://img.icons8.com/metro/26/000000/maintenance.png"
    }
  }

  measure: count_PCOP {
    label: "Number of PCOP Orders"
    filters: {
      field: order_type
      value: "PCOP"
    }
    type: count
    drill_fields: [workorder_details*]
    link: {
      label: "Engineering & Facilities Details"
      url: "/embed/dashboards/uo5bLXwHSFUbskkFeAidva"
      icon_url: "https://img.icons8.com/metro/26/000000/maintenance.png"
    }
  }

  measure: count_RMOP {
    label: "Number of RMOP Orders"
    filters: {
      field: order_type
      value: "RMOP"
    }
    type: count
    drill_fields: [workorder_details*]
    link: {
      label: "Engineering & Facilities Details"
      url: "/embed/dashboards/uo5bLXwHSFUbskkFeAidva"
      icon_url: "https://img.icons8.com/metro/26/000000/maintenance.png"
    }
    }

    measure: count_of_non_PM {
      label: "Number of Non-PMOPs"
      filters: {
        field: order_type
        value: "PCOP,RMOP,BDOP"
      }
      type: count
      drill_fields: [workorder_details*]
      link: {
        label: "Engineering & Facilities Details"
        url: "/embed/dashboards/uo5bLXwHSFUbskkFeAidva"
        icon_url: "https://img.icons8.com/metro/26/000000/maintenance.png"
      }
      }

    measure: pct_bdops_of_total {
      label: "Percent BDOP Orders over Total"
      value_format_name: percent_0
      type:  number
      sql:  1.0*  ${count_BDOP}/${count};;
      link: {
        label: "Engineering & Facilities Details"
        url: "/embed/dashboards/uo5bLXwHSFUbskkFeAidva"
        icon_url: "https://img.icons8.com/metro/26/000000/maintenance.png"
      }
    }


  measure: pct_pmops_of_total {
    label: "Percent PMOP Orders over Total"
    value_format_name: percent_0
    type:  number
    sql: 1.0* ${count_PMOP}/${count};;
    link: {
      label: "Engineering & Facilities Details"
      url: "/embed/dashboards/uo5bLXwHSFUbskkFeAidva"
      icon_url: "https://img.icons8.com/metro/26/000000/maintenance.png"
    }
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
      field: ClosedDate_date
      value: "NULL"
    }
    filters: {
      field: OrderStatus
      value: "OPEN"
    }
    drill_fields: [workorder_details*]
    link: {
      label: "Engineering & Facilities Details"
      url: "/embed/dashboards/uo5bLXwHSFUbskkFeAidva"
      icon_url: "https://img.icons8.com/metro/26/000000/maintenance.png"
    }
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
      field: ClosedDate_date
      value: "NULL"
    }
    filters: {
      field: OrderStatus
      value: "OPEN"
    }
    drill_fields: [workorder_details*]
    link: {
      label: "Engineering & Facilities Details"
      url: "/embed/dashboards/uo5bLXwHSFUbskkFeAidva"
      icon_url: "https://img.icons8.com/metro/26/000000/maintenance.png"
    }
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
    link: {
      label: "Engineering & Facilities Details"
      url: "/embed/dashboards/uo5bLXwHSFUbskkFeAidva"
      icon_url: "https://img.icons8.com/metro/26/000000/maintenance.png"
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
    link: {
      label: "Engineering & Facilities Details"
      url: "/embed/dashboards/uo5bLXwHSFUbskkFeAidva"
      icon_url: "https://img.icons8.com/metro/26/000000/maintenance.png"
    }
  }

    dimension_group:  TechCompletion {
      label: "Technical Completion Date"
    timeframes: [date,hour_of_day,week,week_of_year,day_of_week,day_of_month,month_name, month,quarter,quarter_of_year,year]
    type: time
    sql: ${TABLE}.TechCompletion;;
  }

  dimension_group:  ClosedDate {
    label: "Complete Date"
    timeframes: [date,hour_of_day,week,week_of_year,day_of_week,day_of_month,month_name, month,quarter,quarter_of_year,year]
    type: time
    sql: ${TABLE}.ClosedDate;;
  }

  dimension: date_diff_open_close {
    label: "Days between Open to TECO"
    type: number
    sql: datediff(day,${created_on_date},${ClosedDate_date}) ;;
  }

  measure: average_days_between_open_close {
    type: average
    sql: 1.0 * ${date_diff_open_close};;
    value_format_name: decimal_2
  }

  dimension: OrderStatus
  {
    labe: "Work Order Status"
    type: string
    sql: ${TABLE}.OrderStatus ;;
  }

  dimension: Function_Mapping {
  type: string
  sql:  ${TABLE}.Function_Mapping;;
    link: {
      label: "Engineering & Facilities Details"
      url: "/embed/dashboards/uo5bLXwHSFUbskkFeAidva"
      icon_url: "https://img.icons8.com/metro/26/000000/maintenance.png"
    }
  }

  dimension: EngineeringReportingFlag {
    type: string
    sql: ${TABLE}.EngineeringReportingFlag ;;
    link: {
      label: "Engineering & Facilities Details"
      url: "/embed/dashboards/uo5bLXwHSFUbskkFeAidva"
      icon_url: "https://img.icons8.com/metro/26/000000/maintenance.png"
    }
  }

  dimension: order_no {
    label: "Work Order #"
    type: number
    sql: ${TABLE}.OrderNo ;;
    link: {
      label: "Engineering & Facilities Details"
      url: "/embed/dashboards/uo5bLXwHSFUbskkFeAidva"
      icon_url: "https://img.icons8.com/metro/26/000000/maintenance.png"
    }
  }

  dimension: order_type {
    label: "Work Order Type"
    type: string
    sql: ${TABLE}.OrderType ;;
    link: {
      label: "Engineering & Facilities Details"
      url: "/embed/dashboards/uo5bLXwHSFUbskkFeAidva"
      icon_url: "https://img.icons8.com/metro/26/000000/maintenance.png"
    }
  }

  dimension: reporting_order_type {
    type: string
    sql: ${TABLE}.reporting_order_type ;;
    link: {
      label: "Engineering & Facilities Details"
      url: "/embed/dashboards/uo5bLXwHSFUbskkFeAidva"
      icon_url: "https://img.icons8.com/metro/26/000000/maintenance.png"
    }
  }

  dimension: maint_activ_type {
    type: string
    sql: ${TABLE}.MaintActivType ;;
    link: {
      label: "Engineering & Facilities Details"
      url: "/embed/dashboards/uo5bLXwHSFUbskkFeAidva"
      icon_url: "https://img.icons8.com/metro/26/000000/maintenance.png"
    }
  }

  dimension: description {
    type: string
    sql: ${TABLE}.Description ;;
  }

  dimension: maintenance_plan {
    type: string
    sql: ${TABLE}.MaintenancePlan ;;
    link: {
      label: "Engineering & Facilities Details"
      url: "/embed/dashboards/uo5bLXwHSFUbskkFeAidva"
      icon_url: "https://img.icons8.com/metro/26/000000/maintenance.png"
    }
  }

  dimension: main_work_center {
    label: "Main Work Center"
    type: string
    sql: ${TABLE}.MainWorkCenter ;;
    drill_fields: [workorder_details*]
    link: {
      label: "Engineering & Facilities Details"
      url: "/embed/dashboards/uo5bLXwHSFUbskkFeAidva"
      icon_url: "https://img.icons8.com/metro/26/000000/maintenance.png"
    }
  }

  dimension: functional_location {
    type: string
    sql: ${TABLE}.FunctionalLocation ;;
    drill_fields: [workorder_details*]
    link: {
      label: "Engineering & Facilities Details"
      url: "/embed/dashboards/uo5bLXwHSFUbskkFeAidva"
      icon_url: "https://img.icons8.com/metro/26/000000/maintenance.png"
    }
  }

  dimension: equipment {
    label: "Equipment"
    type: string
    sql: ${TABLE}.Equipment ;;
    drill_fields: [workorder_details*]
  }

  dimension: priority {
    label: "Priority"
    type: string
    sql: ${TABLE}.Priority ;;
    drill_fields: [workorder_details*]
    link: {
      label: "Engineering & Facilities Details"
      url: "/embed/dashboards/uo5bLXwHSFUbskkFeAidva"
      icon_url: "https://img.icons8.com/metro/26/000000/maintenance.png"
    }
  }

  dimension_group: created_on {
    label: "Release Date"
    type: time
    sql: ${TABLE}.CreatedOn ;;

  }

  dimension_group: plan_date {
    label: "Planned Date"
    type: time
    sql: ${TABLE}.PlanDate ;;

  }

  dimension_group: late_date {
    label: "Late Date"
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
      Function_Mapping,
      reporting_order_type,
      EngineeringReportingFlag,
      ClosedDate_date,
      OrderStatus
    ]
  }
}
