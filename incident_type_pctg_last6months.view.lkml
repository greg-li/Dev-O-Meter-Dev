view: incident_type_pctg_last6months {
  derived_table: {
    sql: select hazardType as type_of_incident
        , Pctg
        , sum(Pctg) over (order by pctg desc, hazardType) runningTotal
    , 'nearmiss' as incident_or_neamiss
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

union all

select typeofincident as type_of_incident
        , Pctg
        , sum(Pctg) over (order by pctg desc, typeofincident) runningTotal
    , 'incident' as incident_or_neamiss
      from (
        select TypeOfIncident
          , cast((count(*) * 100 / (sum(count(*)) over ())) as float) / 100 as Pctg
          from datalake.eSafety_Sharepoint_eIncident_List incd
                where IncidentDate > dateadd(MM,-6,IncidentDate)
          and incd.LoadID = (
            select max(LoadID) from datalake.eSafety_Sharepoint_eSafety_List
          )
        group by TypeOfIncident
      ) IncdPctg
 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: type_of_incident {
    type: string
    sql: ${TABLE}.type_of_incident ;;
  }

  dimension: pctg {
    type: number
    sql: ${TABLE}.Pctg ;;
  }

  dimension: running_total {
    type: number
    sql: ${TABLE}.runningTotal ;;
  }

  dimension: incident_or_neamiss {
    type: string
    sql: ${TABLE}.incident_or_neamiss ;;
  }

  set: detail {
    fields: [type_of_incident, pctg, running_total, incident_or_neamiss]
  }
}
