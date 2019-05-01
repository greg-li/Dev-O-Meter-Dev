view: near_miss_hazard_type_last6months {
  derived_table: {
    sql: select hazardType
        , Pctg
        , sum(Pctg) over (order by pctg desc, hazardType) runningTotal
      from (
        select hazardtype
          , cast((count(*) * 100 / (sum(count(*)) over ())) as float) / 100 as Pctg
          from datalake.eSafety_Sharepoint_eSafety_List nm
          where DateOfNearMiss > dateadd(MM,-6,DateOfNearMiss)
          and nm.LoadID = (
            select max(LoadID) from datalake.eSafety_Sharepoint_eSafety_List
          )
        group by HazardType
      ) hazardPctg
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: hazard_type {
    type: string
    sql: ${TABLE}.hazardType ;;
  }

  dimension: pctg {
    type: number
    sql: ${TABLE}.Pctg ;;
  }

  dimension: running_total {
    type: number
    sql: ${TABLE}.runningTotal ;;
  }

  set: detail {
    fields: [hazard_type, pctg, running_total]
  }
}
