view: pmop_open_by_week {
  derived_table: {
    sql: select sun.Sunday
        , (
          select count(*)
          FROM [dataLake].[PMOP_txt_EngAndFacilities] pmop
          where pmop.LoadID = (
            select max(LoadID) from dataLake.PMOP_txt_EngAndFacilities
          )
      and (((pmop.[SystemStatus] like 'CLSD%' or pmop.[SystemStatus] like 'TECO%') and pmop.RefDate > sun.Sunday)
      or (pmop.SystemStatus not like 'CLSD%' and pmop.SystemStatus not like 'TECO%'))
          and sun.Sunday >= pmop.Release
      and pmop.Release > '01/01/1950'
          and (sun.Sunday <= pmop.LateDate or pmop.LateDate = '01/01/1900')
        ) openOnTime
        , (
          select count(*)
          FROM [dataLake].[PMOP_txt_EngAndFacilities] pmop
          where pmop.LoadID = (
          select max(LoadID) from dataLake.PMOP_txt_EngAndFacilities
          )
          and (((pmop.[SystemStatus] like 'CLSD%' or pmop.[SystemStatus] like 'TECO%') and pmop.RefDate > sun.Sunday)
      or (pmop.SystemStatus not like 'CLSD%' and pmop.SystemStatus not like 'TECO%'))
          and sun.Sunday >= pmop.Release
    and pmop.Release > '01/01/1950'
        ) openTotal
       from (
        select dateadd(dd,number,(
          select min(Release)
          from datalake.PMOP_txt_EngAndFacilities
          where Release >= '01/01/1950'
        )) as Sunday
         from master..spt_values
        where type = 'p'
        and DATEPART(dw,dateadd(dd,number,(
          select min(Release)
          from datalake.PMOP_txt_EngAndFacilities
          where Release >= '01/01/1950'
        ))) = 1
        and (
        select dateadd(dd,number,(
          select min(Release)
          from datalake.PMOP_txt_EngAndFacilities
          where Release >= '01/01/1950'
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
