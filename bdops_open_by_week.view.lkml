view: bdops_open_by_week {
  derived_table: {
    sql: select sun.Sunday
        , (
          select count(*)
          FROM [dataLake].[RequestedWork_Excel_EngAndFacilities] rwork
          where rwork.LoadID = (
            select max(LoadID) from [dataLake].[RequestedWork_Excel_EngAndFacilities]
          )
    and rwork.OrderType='BDOP'
      and (((rwork.[SystemStatus] like 'CLSD%' or rwork.[SystemStatus] like 'TECO%') and rwork.[ReferenceDate] > sun.Sunday)
      or (rwork.SystemStatus not like 'CLSD%' and rwork.SystemStatus not like 'TECO%'))
          and sun.Sunday >= rwork.CreatedOn
      and rwork.CreatedOn > '01/01/1950'
          and (sun.Sunday < Cast(DateAdd(day,90,rwork.CreatedOn) as datetime2))
        ) openOnTime
        , (
          select count(*)
          FROM [dataLake].[RequestedWork_Excel_EngAndFacilities] rwork
          where rwork.LoadID = (
          select max(LoadID) from [dataLake].[RequestedWork_Excel_EngAndFacilities]
          )
      and rwork.OrderType='BDOP'
          and (((rwork.[SystemStatus] like 'CLSD%' or rwork.[SystemStatus] like 'TECO%') and rwork.[ReferenceDate] > sun.Sunday)
      or (rwork.SystemStatus not like 'CLSD%' and rwork.SystemStatus not like 'TECO%'))
          and sun.Sunday >= rwork.CreatedOn
    and rwork.CreatedOn > '01/01/1950'
        ) openTotal
       from (
        select dateadd(dd,number,(
          select min(CreatedOn)
          from [dataLake].[RequestedWork_Excel_EngAndFacilities]
          where CreatedOn >= '01/01/1950'
      and [dataLake].[RequestedWork_Excel_EngAndFacilities].OrderType = 'BDOP'
        )) as Sunday
         from master..spt_values
        where type = 'p'
        and DATEPART(dw,dateadd(dd,number,(
          select min(CreatedOn)
          from [dataLake].[RequestedWork_Excel_EngAndFacilities]
          where CreatedOn >= '01/01/1950'
      and [dataLake].[RequestedWork_Excel_EngAndFacilities].OrderType = 'BDOP'
        ))) = 1
        and (
        select dateadd(dd,number,(
          select min(CreatedOn)
          from [dataLake].[RequestedWork_Excel_EngAndFacilities]
          where CreatedOn >= '01/01/1950'
      and [dataLake].[RequestedWork_Excel_EngAndFacilities].OrderType = 'BDOP'
        ))
        ) < getdate()
      ) sun
 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
    link: {
      label: "Engineering & Facilities Details"
      url: "/embed/dashboards/uo5bLXwHSFUbskkFeAidva"
      icon_url: "https://img.icons8.com/metro/26/000000/maintenance.png"
    }
  }

  dimension_group: sunday {
    type: time
    sql: ${TABLE}.Sunday ;;
  }

  dimension: open_on_time {
    type: number
    sql: ${TABLE}.openOnTime ;;
    link: {
      label: "Engineering & Facilities Details"
      url: "/embed/dashboards/uo5bLXwHSFUbskkFeAidva"
      icon_url: "https://img.icons8.com/metro/26/000000/maintenance.png"
    }
  }

  dimension: open_total {
    type: number
    sql: ${TABLE}.openTotal ;;
    link: {
      label: "Engineering & Facilities Details"
      url: "/embed/dashboards/uo5bLXwHSFUbskkFeAidva"
      icon_url: "https://img.icons8.com/metro/26/000000/maintenance.png"
    }
  }

  measure: sum_open_on_time {
    type: sum
    sql: ${open_on_time} ;;
    link: {
      label: "Engineering & Facilities Details"
      url: "/embed/dashboards/uo5bLXwHSFUbskkFeAidva"
      icon_url: "https://img.icons8.com/metro/26/000000/maintenance.png"
    }
  }

  measure: sum_open_total {
    type: sum
    sql: ${open_total} ;;
    link: {
      label: "Engineering & Facilities Details"
      url: "/embed/dashboards/uo5bLXwHSFUbskkFeAidva"
      icon_url: "https://img.icons8.com/metro/26/000000/maintenance.png"
    }
  }

  measure: sum_past_due {
    type: sum
    sql: ${open_total}-${open_on_time} ;;
    link: {
      label: "Engineering & Facilities Details"
      url: "/embed/dashboards/uo5bLXwHSFUbskkFeAidva"
      icon_url: "https://img.icons8.com/metro/26/000000/maintenance.png"
    }
  }

  set: detail {
    fields: [sunday_time, open_on_time, open_total]
  }
}
