view: safety_union {
  derived_table: {
    sql: select id as incidentid, null as nearmissid, incidentcause, assetofevent, createdby, createdbyid, affectedbodypart, building, correctiveaction, created, dateofincidentreport, generalarea, closuredate, employeeid, incidentdate, incidentdescription, LOB, natureofincident, responsiblesupervisor, status, typeofincident, 'incident' as incident_or_nearmiss
      from dataLake.eSafety_Sharepoint_eIncident_List

      union all

      select null as incidentid, id as nearmissid, RootCause as incidentcause, assetofevent, createdby, createdbyid, null as affectedbodypart, building, CorrectiveActionsCompleted as correctiveaction, created, null as dateofincidentreport, generalarea, DateCompleted as closuredate, cast(submitterID as nvarchar) as employeeid, DateAndTimeOfNearMiss as incidentdate, NearMissSafetyObservation as incidentdescription, SubmitterLOB as LOB, null as natureofincident,   ResponsibleParty as responsiblesupervisor, null as status, hazardtype as typeofincident, 'nearmiss' as incident_or_nearmiss
      from dataLake.eSafety_Sharepoint_eSafety_List
       ;;

      persist_for: "24 hours"
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: id {
    hidden: yes
    primary_key: yes
    type: number
    sql: concat(cast(${incident_id} as nvarchar),cast(${nearmiss_id} as nvarchar)) ;;
  }

   dimension: incident_id {
    type: number
    sql: ${TABLE}.incidentid ;;
  }

  dimension: nearmiss_id {
    type: number
    sql: ${TABLE}.nearmissid ;;
  }

  dimension: incidentcause {
    type: string
    sql: ${TABLE}.incidentcause ;;
  }

  dimension: assetofevent {
    type: string
    sql: ${TABLE}.assetofevent ;;
  }

  dimension: createdby {
    type: string
    sql: ${TABLE}.createdby ;;
  }

  dimension: createdbyid {
    type: number
    sql: ${TABLE}.createdbyid ;;
  }

  dimension: affectedbodypart {
    type: string
    sql: ${TABLE}.affectedbodypart ;;
  }

  dimension: building {
    type: string
    sql: ${TABLE}.building ;;
  }

  dimension: correctiveaction {
    type: string
    sql: ${TABLE}.correctiveaction ;;
  }

  dimension_group: created {
    type: time
    sql: ${TABLE}.created ;;
  }

  dimension_group: dateofincidentreport {
    type: time
    sql: ${TABLE}.dateofincidentreport ;;
  }

  dimension: generalarea {
    type: string
    sql: ${TABLE}.generalarea ;;
  }

  dimension_group: closuredate {
    type: time
    sql: ${TABLE}.closuredate ;;
  }

  dimension: employeeid {
    type: string
    sql: ${TABLE}.employeeid ;;
  }

  dimension_group: incidentdate {
    type: time
    sql: ${TABLE}.incidentdate ;;
  }

  dimension: incidentdescription {
    type: string
    sql: ${TABLE}.incidentdescription ;;
  }

  dimension: lob {
    type: string
    sql: ${TABLE}.LOB ;;
  }

  dimension: natureofincident {
    type: string
    sql: ${TABLE}.natureofincident ;;
  }

  dimension: responsiblesupervisor {
    type: string
    sql: ${TABLE}.responsiblesupervisor ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: typeofincident {
    type: string
    sql: ${TABLE}.typeofincident ;;
  }

  dimension: incident_or_nearmiss {
    type: string
    sql: ${TABLE}.incident_or_nearmiss ;;
  }

  set: detail {
    fields: [
      id,
      incidentcause,
      assetofevent,
      createdby,
      createdbyid,
      affectedbodypart,
      building,
      correctiveaction,
      created_time,
      dateofincidentreport_time,
      generalarea,
      closuredate_time,
      employeeid,
      incidentdate_time,
      incidentdescription,
      lob,
      natureofincident,
      responsiblesupervisor,
      status,
      typeofincident,
      incident_or_nearmiss
    ]
  }
}
