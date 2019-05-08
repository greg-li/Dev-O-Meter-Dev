view: pmop_open_by_week {
  derived_table: {
    sql: select sun.Sunday
        , (
          select count(*)
          FROM [dataLake].[PMOP_txt_EngAndFacilities] pmop
          left join dataLake.TECO_Excel_EngAndFacilities teco
          on pmop.OrderNo = teco.OrderNo
          and teco.LoadID = (
            select max(LoadID) from dataLake.TECO_Excel_EngAndFacilities
          )
          where pmop.LoadID = (
          select max(LoadID) from dataLake.PMOP_txt_EngAndFacilities
          )
          and (teco.TechCompletion is null or teco.TechCompletion > sun.Sunday)
          and sun.Sunday >= pmop.Release
      and pmop.Release > '01/01/1950'
          and (sun.Sunday <= pmop.LateDate or pmop.LateDate = '01/01/1900')
        ) openOnTime
        , (
          select count(*)
          FROM [dataLake].[PMOP_txt_EngAndFacilities] pmop
          left join dataLake.TECO_Excel_EngAndFacilities teco
          on pmop.OrderNo = teco.OrderNo
          and teco.LoadID = (
            select max(LoadID) from dataLake.TECO_Excel_EngAndFacilities
          )
          where pmop.LoadID = (
          select max(LoadID) from dataLake.PMOP_txt_EngAndFacilities
          )
          and (teco.TechCompletion is null or teco.TechCompletion > sun.Sunday)
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
  }

  dimension_group: sunday {
    type: time
    sql: ${TABLE}.Sunday ;;
  }

  dimension: open_on_time {
    type: number
    sql: ${TABLE}.openOnTime ;;
  }

  dimension: open_total {
    type: number
    sql: ${TABLE}.openTotal ;;
  }

  measure: sum_open_on_time {
    type: sum
    sql: ${open_on_time} ;;
  }

  measure: sum_open_total {
    type: sum
    sql: ${open_total} ;;
  }

  measure: sum_past_due {
    type: sum
    sql: ${open_total}-${open_on_time} ;;
  }

  set: detail {
    fields: [sunday_time, open_on_time, open_total]
  }
}
